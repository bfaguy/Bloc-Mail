require 'spec_helper'

feature "User sees a single campaign with details" do

  scenario "successfully" do
    campaign_title = "Your order has been shipped"
    campaign_id = '123'
    campaign_content = "this ministry is awesome! we need to be constitute"
    mock_mc_campaigns(campaign_title, campaign_content)

    visit "/campaigns/#{campaign_id}"
    expect(page).to have_content(campaign_title)
    expect(page).to have_content(campaign_content)


  end

end
