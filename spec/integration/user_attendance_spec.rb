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

  scenario 'User visits attemps to attend an event' do
    event1.attendees << user2
    log_in_with(user1.name)
    visit event_path(event1)

    click_link('Attend event')

    expect(event1.attendees.find_by(id: user1.id)).to eql(user1)
  end
  scenario 'User doesnt attend an event' do
    event1.attendees << user2
    start = event1.attendees.count
    log_in_with(user1.name)
    visit event_path(event1)

    finish = event1.attendees.count

    expect(start).to eql(finish)
  end
end
