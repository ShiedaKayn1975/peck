class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :tags
      t.string :images
      t.float :quality_commitment
      t.float :price
      t.bigint :creator_id

      t.timestamps
    end
  end
end
