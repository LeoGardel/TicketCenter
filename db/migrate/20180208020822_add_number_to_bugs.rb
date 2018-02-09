class AddNumberToBugs < ActiveRecord::Migration[5.0]
  def change
  	add_column :bugs, :number, :integer
  end
end
