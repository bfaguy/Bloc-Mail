require 'spec_helper'

feature "User purges list" do

  let(:user) {create :user}

  context "when logged in" do
    scenario "and removes old emails" do
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

  context "when not logged in" do
    scenario "should not be able to see 'Lists'" do
      visit root_path
      expect(page).to_not have_content('Lists')
    end
  end
end
