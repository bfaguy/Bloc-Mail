class ListsController < ApplicationController

  include ListUtil

  def index
    begin
      lists_res = @mc.lists.list
      @lists = lists_res['data']
    rescue Mailchimp::Error => ex
      if ex.message
        flash[:error] = ex.message
      else
        flash[:error] = "An unknown error occurred"
      end
      redirect_to "/"
    end
  end

  def show
    list_id = params[:id]
    begin
      lists_res = @mc.lists.list({'list_id' => list_id})
      @list = lists_res['data'][0]

      @members = @gibbon_export.list({:id => list_id})
      headers = JSON.parse(@members.shift)

      for i in 0..headers.length
        if headers[i] == "Email Address"
          @email_index = i
        elsif headers[i] == "First Name"
          @firstname_index = i
        elsif headers[i] == "Last Name"
          @lastname_index = i
        elsif headers[i] == "CONFIRM_TIME"
          @confirmtime_index = i
        elsif headers[i] == "MEMBER_RATING"
          @rating_index = i
        end
      end

      @members = @members.paginate(page: params[:page], per_page:25)

    rescue Mailchimp::ListDoesNotExistError
      flash[:error] = "The list could not be found"
      redirect_to "/lists/"
    rescue Mailchimp::Error => ex
      if ex.message
        flash[:error] = ex.message
      else
        flash[:error] = "An unknown error occurred"
      end
      redirect_to "/lists/"
    end
  end

  def subscribe
    list_id = params[:id]
    email = params['email']
    begin
      @mc.lists.subscribe(params[:id], {'email' => email})
      flash[:success] = "#{email} subscribed successfully"
    rescue Mailchimp::ListAlreadySubscribedError
      flash[:error] = "#{email} is already subscribed to the list"
    rescue Mailchimp::ListDoesNotExistError
      flash[:error] = "The list could not be found"
      redirect_to "/lists/"
      return
    rescue Mailchimp::Error => ex
      if ex.message
        flash[:error] = ex.message
      else
        flash[:error] = "An unknown error occurred"
      end
    end
    redirect_to "/lists/#{list_id}"
  end

  def purge
    list_id = params[:id]
    days_old_threshold = params[:days_old].to_i

    lists_res = @mc.lists.list({'list_id' => list_id})
    list_name = lists_res['data'][0]['name']

    begin
      members = @gibbon_export.list({:id => list_id})

      if members[0].include? "Email Address"
        members.shift
      end

      unsubscribe_result  = cleanup_segment(members, @mc, list_name, list_id, current_user.id, days_old_threshold)

      num_errors = unsubscribe_result["error_count"]
      num_unsubscribed = unsubscribe_result["success_count"]

      if (num_errors > 0)
        flash[:error] = "Encountered #{num_errors} error(s) while processing unsubscribe"
      end

      if (num_unsubscribed > 0)
        flash[:notice] = "Succesfully unsubscribed #{num_unsubscribed} "+
          "member".pluralize(num_unsubscribed)
      else
        flash[:alert] = "No members unsubscribed"
      end

    rescue Mailchimp::ListDoesNotExistError
      flash[:error] = "The list could not be found"
      redirect_to "/lists/"
      return
    rescue Mailchimp::Error => ex
      if ex.message
        flash[:error] = ex.message
      else
        flash[:error] = "An unknown error occurred"
      end
    end
    redirect_to "/lists/#{list_id}"
  end

end
