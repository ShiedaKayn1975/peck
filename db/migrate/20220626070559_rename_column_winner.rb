class RenameColumnWinner < ActiveRecord::Migration[6.0]
  def change
    rename_column :auction_products, :winner, :winner_id
  end
end
