class CampaignsController < ApplicationController

  def index
    begin
      campaigns_res = @mc.campaigns.list
      @campaigns = campaigns_res['data']
    rescue Mailchimp::Error => ex
      if ex.message
        flash[:error] = ex.message
      else
        flash[:error] = "An unknown error occurred"
      end
      redirect_to "/"
    end
  end

end
