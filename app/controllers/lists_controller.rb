class ListsController < ApplicationController

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
      @members.shift
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

  def purge
    list_id = params[:id]
    begin
      members = @gibbon_export.list({:id => list_id})
      members.shift
      number_unsubscribed = cleanup_segment(members)
      if (number_unsubscribed > 0)
        flash[:success] = "succesfully unsubscribed #{number_unsubscribed} member(s)"
      else
        flash[:notice] = "no members unsubscribed"
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

  private 

  def cleanup_segment(members)
    number_unsubscribed = 0
    begin
      members.each do |member_json|
        member = JSON.parse(member_json)
        member_date = Date.parse(member[6])
        days_old = (Date.today+10) - member_date
        if days_old > BlocMail::Application::DAYS_OLD_THRESHOLD
          return_value = @mc.lists.unsubscribe(params[:id], 
                                               {'email' => member[0]}, :delete_member => false,
                                               :send_goodbye => false, 
                                               :send_notify => false)
          if (return_value['complete'])
            number_unsubscribed += 1
          end
        end
      end
    end
    number_unsubscribed
  end

end
