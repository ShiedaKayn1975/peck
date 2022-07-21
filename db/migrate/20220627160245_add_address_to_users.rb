class AddAddressToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :address, :jsonb
  end
end
