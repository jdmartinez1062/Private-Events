require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'create event' do
    it 'Event creation relation for user' do
      user = User.create(name: 'test1', email: 'test1@email.com')
      event = user.created_events.create(date: Time.now, location: "#{user.name}'s house")
      expect(user.created_events.first).to eql(event)
      expect(event.creator).to eql(user)
    end
  end
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
end
