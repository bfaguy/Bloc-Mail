module  UserHelper

  def login(a)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: a.email
    fill_in 'Password', with: a.password
    click_button 'Sign in'
  end

  def logout(a)
    visit root_path
    click_link 'Sign Out'
  end

end

