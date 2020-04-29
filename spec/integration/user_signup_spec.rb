require 'rails_helper'

RSpec.feature 'User signup', type: :feature do
  scenario 'User signs up gets redirected to user profile' do
    user = User.new(name: 'test1', email: 'test1@email.com')
    visit signup_path

    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email
    click_button 'Sign up'
    user = User.last
    expect(page).to have_text('Log out')
    expect(page).to have_current_path(user_path(user))
  end
  scenario 'User invalid sign up' do
    user = User.new(name: '', email: 'test1@email.com')
    visit signup_path

    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email
    click_button 'Sign up'
    expect(page).to have_text('Sign up unsuccessfull')
    expect(page).to have_current_path(signup_path)
  end
end
