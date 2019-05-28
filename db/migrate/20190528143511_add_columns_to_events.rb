class AddColumnsToEvents < ActiveRecord::Migration[5.2]
  def change
    #add_column :events, :column_name, :column_type
    add_column :events, :opening_hour, :string
    add_column :events, :closing_hour, :string
    add_column :events, :event_description, :text
    add_column :events, :img_url, :string
    add_column :events, :admission, :string
    add_column :events, :date_start, :date
    add_column :events, :date_end, :date
    add_column :events, :api_id, :string
    add_column :events, :venue_type, :string
  end
end
