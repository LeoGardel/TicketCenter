class CreateBugs < ActiveRecord::Migration[5.0]
  def change
    create_table :bugs do |t|
      t.references :project, foreign_key: true
      t.string :description
      t.integer :status
      t.integer :user_status
      t.date :date_status

      t.timestamps
    end
  end
end
