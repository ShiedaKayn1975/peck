class CreateUserSecurityGateways < ActiveRecord::Migration[6.0]
  def change
    create_table :user_security_gateways do |t|
      t.references :security_gateway, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :current_step
      t.string :status

      t.timestamps
    end
  end
end
