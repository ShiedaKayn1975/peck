class ChangeColumnActiveInUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :active
    add_column    :users, :status, :string
  end
end
