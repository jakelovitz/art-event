class AddFreeToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :free, :boolean
  end
end
