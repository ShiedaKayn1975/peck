class ChangeStepsToJsonb < ActiveRecord::Migration[6.0]
  def change
    remove_column :security_gateways, :steps
    add_column :security_gateways, :steps, :jsonb, default: {}
  end
end
