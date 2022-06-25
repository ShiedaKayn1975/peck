class AddCurrentAppToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :current_app, :string
  end
end
