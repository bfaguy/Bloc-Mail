require 'spec_helper'

feature "User can scroll through paginated members on list view" do

  scenario "succesfully" do
    email = "admin@example.com"
    mock_gibbon_list(30, email)

    visit "/lists/123"
    expect(page).to have_content(email)
    expect(page).to have_content("Previous")
    click_link "Next"
    expect(page).to_not have_content(email)
  end
end

