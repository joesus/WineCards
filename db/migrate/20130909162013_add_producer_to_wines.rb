class AddProducerToWines < ActiveRecord::Migration
  def change
  	add_column :wines, :producer, :string
  	add_index :wines, :producer
  end
end