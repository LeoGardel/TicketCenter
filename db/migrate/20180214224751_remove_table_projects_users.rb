class RemoveTableProjectsUsers < ActiveRecord::Migration[5.0]
  def change
  	drop_table :projects_users
  end
end
