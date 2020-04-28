require 'rails_helper'

def log_in_with(name)
  visit login_path

  fill_in 'Name', with: name
  click_button 'Log in!'
end

RSpec.describe UsersController, type: :controller do
  let! (:user1) { User.create(name: 'test1', email: 'test1@email.com') }
  let! (:user2) { User.create(name: 'test2', email: 'test2@email.com') }
  let! (:event1) { user1.created_events.create(date: 2.days.from_now, location: "#{user1.name}'s house 1") }
  let! (:event2) { user1.created_events.create(date: 2.days.ago(Time.now), location: "#{user1.name}'s house 2") }

  describe 'attend an event' do
    it 'attends and event when logged in' do
      post attend_event_path(event1)

      expect(user1.attended_events.first).to eq(event1)
    end

    it 'attends and event when not logged in' do
    end
  end
end
