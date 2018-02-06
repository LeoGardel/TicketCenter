class CreateProjetos < ActiveRecord::Migration[5.0]
  def change
    create_table :projetos do |t|
      t.string :name
      t.date :initial_date
      t.string :description

      t.timestamps
    end
  end
end
