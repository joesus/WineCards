class AddNameToWines < ActiveRecord::Migration
  def change
  	add_column :wines, :name, :string
  	add_index :wines, :name
  end
end
