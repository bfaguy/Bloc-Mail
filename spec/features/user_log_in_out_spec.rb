require 'spec_helper'

feature 'User visits BlocMail' do

  let(:user) { create :user }

  scenario 'can login' do
    login(user)
    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'can logout' do
    login(user)
    logout(user)
    expect(page).to have_content('Signed out successfully.')
  end

  scenario 'with invalid password' do
    visit new_user_session_path
    fill_in 'Email', with: user.email 
    fill_in 'Password', with: 'fjalkj2353'
    click_button 'Sign in'
    expect(page).to have_content('Invalid email or password.')
  end

end


