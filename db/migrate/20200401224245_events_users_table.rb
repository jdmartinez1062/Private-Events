class EventsUsersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :events_users, id: false do |t|

      t.bigint :creator_id
      t.bigint :attendant_id
      t.bigint :event_id
    end

    add_index :events_users, :creator_id
    add_index :events_users, :attendant_id
    add_index :events_users, :event_id
  end
end
