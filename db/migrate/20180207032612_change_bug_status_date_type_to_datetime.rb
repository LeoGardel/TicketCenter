class ChangeBugStatusDateTypeToDatetime < ActiveRecord::Migration[5.0]
  def change
  	change_column :bugs, :date_status, :datetime
  end
end
