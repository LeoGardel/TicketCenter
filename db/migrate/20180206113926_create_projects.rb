class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.date :start_date
      t.integer :manager_id

      t.timestamps
    end
  end
end
