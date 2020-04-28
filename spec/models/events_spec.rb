require 'rails_helper'

RSpec.describe Event, type: :model do
  let (:user) { User.create(name: 'test1', email: 'test1@email.com') }
  describe 'create event' do
    it 'Event creation ' do
      event = user.created_events.create(date: Time.now, location: "#{user.name}'s house")
      expect(Event.count).to eql(1)
    end
  end
  describe 'create event' do
    it 'Event creation' do
      event = user.created_events.create(date: Time.now, location: "#{user.name}'s house")
      expect(Event.count).to eql(1)
    end
    it 'Failed event creation due to date' do
      event = user.created_events.create(date: 'Time.now', location: "#{user.name}'s house")
      expect(Event.count).to eql(0)
    end
    it 'Failed event creation due to empty date' do
      event = user.created_events.create(date: '', location: "#{user.name}'s house")
      expect(Event.count).to eql(0)
    end
    it 'Failed event creation due to empty location' do
      event = user.created_events.create(date: Time.now, location: '')
      expect(Event.count).to eql(0)
    end
    it 'Failed event creation due to empty attributes' do
      event = user.created_events.create(date: '', location: '')
      expect(Event.count).to eql(0)
    end
  end
end
