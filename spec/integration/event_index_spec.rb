require 'rails_helper'

RSpec.feature 'Events index', type: :feature do
  let!(:user) { User.create(name: 'test1', email: 'test1@email.com') }
  let!(:event1) { user.created_events.create(date: Time.now, location: "#{user.name}'s house 1") }
  let!(:event2) { user.created_events.create(date: Time.now, location: "#{user.name}'s house 2") }

  scenario 'User visits event index page' do
    visit events_path

    events_fp = Event.paginate(page: 1)
    expect(page).to have_css('h1', text: 'Events#index')
    events_fp.each do |event|
      expect(page).to have_css('a', text: event.location)
      expect(page).to have_css('p', text: "Date: #{event.date}")
      expect(page).to have_css('p', text: "Creator: #{event.creator.name}")
    end
  end
end
