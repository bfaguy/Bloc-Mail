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

  def view
    list_id = params[:id]
    begin
      lists_res = @mc.lists.list({'list_id' => list_id})
      @list = lists_res['data'][0]
      members_res = @mc.lists.members(list_id)
      @members = members_res['data']
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
      members_res = @mc.lists.members( list_id, "subscribed", :limit => 100)
      members = members_res['data']
      number_unsubscribed = cleanupSegment(members)
      flash[:success] = "succesfully unsubscribed #{number_unsubscribed} email(s)"
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

  def cleanupSegment(members)
    number_unsubscribed = 0
    begin
      members.each do |member|
        member_date = Date.parse(member['timestamp'])
        days_old = Date.today - member_date
        if days_old > BlocMail::Application::DAYS_OLD_THRESHOLD
          @mc.lists.unsubscribe(params[:id], {'email' => member['email']}, :delete_member => false,
                                :send_goodbye => false, 
                                :send_notify => false)
          number_unsubscribed += 1
        end
      end
    end
    number_unsubscribed
  end

end
