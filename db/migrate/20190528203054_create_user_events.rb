class CreateUserEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :user_events do |t|
      t.integer :user_id, null: false
      t.integer :event_id, null: false
      t.timestamp
    end
  end
end
