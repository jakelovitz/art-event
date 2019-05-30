class AddValidatedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :validated, :boolean, default: false
  end
end
