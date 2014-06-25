require 'spec_helper'

feature "User sees index of mailchimp campaigns" do

  scenario "successfully" do
    campaign_title = "Your order has been shipped"
    mock_mc_campaigns(campaign_title)

    visit campaigns_path
    expect(page).to have_content("Your MailChimp Campaigns")
    expect(page).to have_content(campaign_title)
  end
end
