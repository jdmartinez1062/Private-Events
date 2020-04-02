class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :location
      t.datetime :date
      t.bigint :creator_id

      t.timestamps
    end
    add_index :events, :creator_id
  end
end
