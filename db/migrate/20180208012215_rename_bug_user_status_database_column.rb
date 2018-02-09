class RenameBugUserStatusDatabaseColumn < ActiveRecord::Migration[5.0]
  def change
  	rename_column :bugs, :user_status, :user_status_id
  end
end
