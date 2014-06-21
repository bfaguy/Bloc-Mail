require 'spec_helper'

feature "User can scroll through paginated members on list view" do

  # note: this test requires the rails server to be running 
  scenario "succesfully" do
    email = "admin@example.com"
    setup_gibbon_list(email, 30)

    visit "/lists/123"
    expect(page).to have_content(email)
    expect(page).to have_content("Previous")
    click_link "Next"
    expect(page).to_not have_content(email)
  end
end

