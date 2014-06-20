require 'spec_helper'

feature "User sees a single list with details" do

  scenario "Successfully" do
    list_name = 'new list'
    list_id = '123'
    member_email = 'jon@bloc.com'
    setup_mc_mocks(list_name, list_id, member_email)

    visit "/lists/#{list_id}"
    expect(page).to have_content(list_name)
    expect(page).to have_content(member_email)
  end
end
