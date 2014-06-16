require 'spec_helper'

feature "User purges list and removes old emails" do

  scenario "successfully" do
    pending "will write controller specs first"
    list_id = '123'
    email_address = 'jon@bloc.com'
    setup_mc(list_id, "list", email_address)
    # visit lists_path, '123'
    visit "/lists/#{list_id}"
    # save_and_open_page
    expect(page).to have_content(email_address)
    click_button 'Purge List'
    expect(page).to have_content("succesfully unsubscribed 1 email(s)")
    expect(page).to_not have_content(email_address)
  end
end
