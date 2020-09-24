def log_in(name)
  post login_path, params: { session: { name: name.to_s } }
end

RSpec.describe UsersController, type: :request do
  let!(:user1) { User.create(name: 'test1', email: 'test1@email.com') }
  let!(:user2) { User.create(name: 'test2', email: 'test2@email.com') }
  let!(:event1) { user1.created_events.create(date: 2.days.from_now, location: "#{user1.name}'s house 1") }
  let!(:event2) { user1.created_events.create(date: 2.days.ago(Time.now), location: "#{user1.name}'s house 2") }

  describe 'user attemps to attend an event' do
    it 'the event exists' do
      log_in(user2.name)
      expect do
        post attend_event_path(event1)
      end.to change(user2.attended_events, :count).by(1)
    end
  end
end
