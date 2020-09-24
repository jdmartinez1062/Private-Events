require 'rails_helper'

def log_in_with(name)
  visit login_path

  fill_in 'Name', with: name
  click_button 'Log in!'
end

RSpec.feature 'Event show page', type: :feature do
  let!(:user1) { User.create(name: 'test1', email: 'test1@email.com') }
  let!(:user2) { User.create(name: 'test2', email: 'test2@email.com') }
  let!(:event1) { user1.created_events.create(date: 2.days.from_now, location: "#{user1.name}'s house 1") }
  let!(:event2) { user1.created_events.create(date: 2.days.ago(Time.now), location: "#{user1.name}'s house 2") }

  scenario 'User visits event index page when not logged in' do
    event1.attendees << user1
    event1.attendees << user2
    visit event_path(event1)

    attendants = event1.attendees.paginate(page: 1)
    expect(attendants.count).to eql(2)
    attendants.each do |attendant|
      expect(page).to have_css('li', text: attendant.name)
    end
  end
  scenario 'User visits event index page when logged in' do
    log_in_with(user2.name)

    event1.attendees << user1
    event1.attendees << user2
    visit event_path(event1)

    attendants = event1.attendees.paginate(page: 1)
    expect(attendants.count).to eql(2)
    expect(page).to have_css('a', text: 'Attend event')
    attendants.each do |attendant|
      expect(page).to have_css('li', text: attendant.name)
    end
  end
end
