class AddFieldsToProducts < ActiveRecord::Migration[6.0]
  def change
    # add_column :products, :description, :text
    # add_column :products, :categories, :jsonb
    # change_column :products, :images, :string
    remove_column :products, :images
  end
end
