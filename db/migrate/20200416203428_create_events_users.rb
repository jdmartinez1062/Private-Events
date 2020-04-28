# frozen_string_literal: true

class CreateEventsUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :events_users, id: false do |t|
      t.bigint :attendee_id
      t.bigint :attended_event_id
    end
    add_index :events_users, :attendee_id
    add_index :events_users, :attended_event_id
  end
end
