class AddCategoryToWines < ActiveRecord::Migration
  def change
  	add_column :wines, :category, :string
  	add_index :wines, :category
  end
end