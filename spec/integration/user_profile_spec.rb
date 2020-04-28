require 'rails_helper'

def log_in_with(name)
  visit login_path

  fill_in 'Name', with: name
  click_button 'Log in!'
end

RSpec.feature 'User profile', type: :feature do
  let! (:user1) { User.create(name: 'test1', email: 'test1@email.com') }
  let! (:user2) { User.create(name: 'test2', email: 'test2@email.com') }
  let! (:event1) { user1.created_events.create(date: 2.days.from_now, location: "#{user1.name}'s house 1") }
  let! (:event2) { user1.created_events.create(date: 2.days.ago(Time.now), location: "#{user1.name}'s house 2") }
  let! (:event3) { user2.created_events.create(date: Time.now, location: "#{user2.name}'s house") }

  scenario 'User visits his show page' do
    log_in_with(user2.name)

    user2.attended_events << event1
    user2.attended_events << event2

    visit user_path(user2)

    created_e = user2.created_events.paginate(page: 1)
    past_e = user2.previous_events.paginate(page: 1)
    upcoming_e = user2.upcoming_events.paginate(page: 1)

    expect(page).to have_text(user2.name)
    expect(user2.created_events.count).to eql(1)
    expect(user2.attended_events.count).to eql(2)
    expect(past_e.count).to eql(1)
    expect(upcoming_e.count).to eql(1)

    created_e.each do |event|
      expect(page).to have_css('a', text: event.location)
      expect(page).to have_css('p', text: "Date: #{event.date}")
      expect(page).to have_css('p', text: "Creator: #{event.creator.name}")
    end

    past_e.each do |event|
      expect(page).to have_css('a', text: event.location)
      expect(page).to have_css('p', text: "Date: #{event.date}")
      expect(page).to have_css('p', text: "Creator: #{event.creator.name}")
    end

    upcoming_e.each do |event|
      expect(page).to have_css('a', text: event.location)
      expect(page).to have_css('p', text: "Date: #{event.date}")
      expect(page).to have_css('p', text: "Creator: #{event.creator.name}")
    end
  end
end
