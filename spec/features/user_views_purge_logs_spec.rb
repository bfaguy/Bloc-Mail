require 'spec_helper'

feature 'User can view logs of purges' do 

  let(:user) { create(:user) }

  scenario 'succesfully' do

    list_id = "123"
    time_created = Time.now
    list_name = "Test List"

    purge = create(:purge, list_id: list_id, list_name: list_name, user_id: user.id,
                   created_at: time_created, 
                   unsubscribed_count: 1,
                   errors_count: 0)


    login(user)
    visit purges_path 
    expect(page).to have_content("List Id")
    expect(page).to have_content(purge.list_id)
    expect(page).to have_content("Name (email)")
    expect(page).to have_content(user.name)
    expect(page).to have_content("List Name")
    expect(page).to have_content(purge.list_name)
    expect(page).to have_content("Errors")
    expect(page).to have_content("Unsubscribed")

  end

end
