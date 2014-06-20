require 'spec_helper'

feature "User purges list and removes old emails" do

  let(:user) {create :user}

  scenario "successfully" do
    email_address = 'jon@bloc.com'

    setup_mc_mocks("new list", '123', email_address)

    login(user)
    visit "/lists/123" # doesn't matter what list id is
    expect(page).to have_content(email_address)
    click_button 'Purge List'
    expect(page).to have_content("Succesfully unsubscribed 1 member")
    expect(page).to_not have_content(email_address)
  end

end
