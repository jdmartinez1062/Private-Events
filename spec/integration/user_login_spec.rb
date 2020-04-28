require 'rails_helper'

RSpec.feature 'User login', type: :feature do
  let! (:user) { User.create(name: 'test1', email: 'test1@email.com') }
  scenario 'User logs in and gets redirected to user profile' do
    visit login_path

    fill_in 'Name', with: user.name
    click_button 'Log in!'

    expect(page).to have_text('Log out')
    expect(page).to have_current_path(user_path(user))
  end
  scenario 'Unsuccesful sign up' do
    visit login_path

    fill_in 'Name', with: 'not an user name'
    click_button 'Log in!'

    expect(page).to have_text('Log in ussucessful')
    expect(page).to have_current_path(login_path)
  end
end
