class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :event_name
      t.string :venue_name
      t.string :address
      t.string :phone
      t.string :directions
      t.string :neighborhood
      t.timestamps
    end
  end
end
