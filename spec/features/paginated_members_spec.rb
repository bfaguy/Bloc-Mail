require 'spec_helper'

feature "User can scroll through paginated members on list view" do

  scenario "succesfully" do
    list_id = '123'
    email = "admin@example.com"
    # mock_gibbon_list(30, email)
    setup_mc_mocks("new list", list_id, email, 30) 

    visit "/lists/#{list_id}"
    expect(page).to have_content(email)
    expect(page).to have_content("Previous")
    click_link "Next"
    expect(page).to_not have_content(email)
  end
end

