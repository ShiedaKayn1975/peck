class AddFieldToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :description, :text
    add_column :products, :categories, :jsonb
    add_column :products, :images, :string, array: true
  end
end
