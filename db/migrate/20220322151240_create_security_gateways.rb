class CreateSecurityGateways < ActiveRecord::Migration[6.0]
  def change
    create_table :security_gateways do |t|
      t.string :code
      t.string :name
      t.text :steps, array: true, default: []

      t.timestamps
    end
  end
end
