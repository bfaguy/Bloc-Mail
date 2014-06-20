#require Rails.root.join('lib/list_util.rb')
require 'list_util'

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

      if members[0].include? "Email Address"
        members.shift
      end

      cleanup_result  = cleanup_segment(members, @mc, list_id, current_user.id)
      if (cleanup_result[:error_message])
        flash[:error] = cleanup_result[:error_message]
      elsif (cleanup_result[:number_unsubscribed] > 0)
        flash[:notice] = "Succesfully unsubscribed #{cleanup_result[:number_unsubscribed]} "+
          "member".pluralize(cleanup_result[:number_unsubscribed])
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
