require 'spec_helper'

feature "User purges list and removes old emails" do

  let(:user) {create :user}

  scenario "successfully" do
    email_address = 'jon@bloc.com'
    setup_gibbon_list(email_address, 2)
    login(user)
    visit "/lists/123" # doesn't matter what list id is
    expect(page).to have_content(email_address)
    save_and_open_page
    click_button 'Purge List'
    expect(page).to have_content("succesfully unsubscribed 1 email(s)")
    expect(page).to_not have_content(email_address)
  end

end
