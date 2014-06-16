require 'spec_helper'

feature "User sees a single list with details" do

  let(:list_name) {'new list'}
  let(:list_id) {'123'}
  let(:member_email) {'guy@bloc.com'}

  scenario "Successfully" do
    setup_mc(list_name, list_id, member_email)
    visit "/lists/#{list_id}"
    expect(page).to have_content(list_name)
    expect(page).to have_content(member_email)
  end
end
