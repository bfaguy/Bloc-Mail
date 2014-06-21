require 'spec_helper'

feature 'User can view logs of purges' do 

  let(:user) { create(:user) }

  scenario 'succesfully' do

    list_id = "123"
    time_created = Time.now
    unsubscribed_count = 2

    purge = create(:purge, list_id: list_id, user_id: user.id,
                   created_at: time_created, unsubscribed_count: unsubscribed_count)

    login(user)
    visit purges_path 
    expect(page).to have_content("List Id")
    expect(page).to have_content(purge.list_id)

  end

end
