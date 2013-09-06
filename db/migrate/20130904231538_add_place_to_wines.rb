class AddPlaceToWines < ActiveRecord::Migration
  def change
  	add_column :wines, :place, :string
  	add_index :wines, :place
  end
end
