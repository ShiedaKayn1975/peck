class AddErrorToActionLogs < ActiveRecord::Migration[6.0]
  def change
    add_column :action_logs, :error, :jsonb
  end
end
