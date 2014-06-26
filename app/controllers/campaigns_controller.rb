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

  def show
    campaign_id = params[:id]
    begin

      @campaign = {}  
      campaigns_res = @mc.campaigns.list({'campaign_id' => campaign_id})
      @campaign['title'] = campaigns_res['data'][0]['title']
      @campaign['content'] = @mc.campaigns.content(campaign_id)['html']
    rescue Mailchimp::CampaignDoesNotExistError
      flash[:error] = "The campaign could not be found"
      redirect_to "/campaigns/"
    rescue Mailchimp::Error => ex
      if ex.message
        flash[:error] = ex.message
      else
        flash[:error] = "An unknown error occurred"
      end
      redirect_to "/campaigns/"
    end
  end

end
