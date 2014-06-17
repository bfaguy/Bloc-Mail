require 'spec_helper'

feature "User can scroll through paginated members on list view" do

  scenario "succesfully" do
    list_id = '669c2edd5f'
    email = "admin@example.com"
    setup_mc_with_fake_email(email)

    visit "/lists/#{list_id}"
    expect(page).to have_content("Previous")
    # expect(page).to have_content(email)
    click_link "Next"
    expect(page).to_not have_content(email)
  end
end

