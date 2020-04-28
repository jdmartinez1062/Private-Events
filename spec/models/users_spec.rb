require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'create user' do
    it 'User creation' do
      user = User.create(name: 'test1', email: 'test1@email.com')
      expect(User.count).to eql(1)
    end
    it 'Failed user creation due to email' do
      user = User.create(name: 'test1', email: 'test1email.com')
      expect(User.count).to eql(0)
    end
    it 'Failed user creation due to empty name' do
      user = User.create(name: '', email: 'test1email.com')
      expect(User.count).to eql(0)
    end
    it 'Failed user creation due to empty attributes' do
      user = User.create(name: '', email: '')
      expect(User.count).to eql(0)
    end
  end
  describe 'create event' do
    it 'Event creation relation for user' do
      user = User.create(name: 'test1', email: 'test1@email.com')
      event = user.created_events.create(date: Time.now, location: "#{user.name}'s house")
      expect(user.created_events.first).to eql(event)
      expect(event.creator).to eql(user)
    end
  end
  describe 'attend event' do
    it 'Event attendance relation for user' do
      user = User.create(name: 'test1', email: 'test1@email.com')
      event = user.created_events.create(date: Time.now, location: "#{user.name}'s house")
      attendant = User.create(name: 'test2', email: 'test2@email.com')
      attendant.attended_events << event
      expect(attendant.attended_events.first).to eql(user.created_events.first)
      expect(event.attendees.first).to eql(attendant)
    end
  end
end
