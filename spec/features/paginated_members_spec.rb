require 'spec_helper'

feature "User can scroll through paginated members on list view" do

  # note: this test requires the rails server to be running 
  scenario "succesfully" do
    list_id = '669c2edd5f' # list on testing mailchimp account
    email = "admin@example.com"
    setup_gibbon_list(email, list_id)

    visit "/lists/#{list_id}"
    expect(page).to have_content("Previous")
    expect(page).to have_content(email)
    click_link "Next"
    expect(page).to_not have_content(email)
  end
end

