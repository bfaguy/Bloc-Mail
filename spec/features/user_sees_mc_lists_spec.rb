require 'spec_helper'

feature "User sees index of mailchimp lists" do

  scenario "successfully" do
    list_name = "Order Shipped List"
    setup_mc_mocks(list_name)

    visit lists_path
    expect(page).to have_content("Your MailChimp Lists")
    expect(page).to have_content(list_name)
  end
end
