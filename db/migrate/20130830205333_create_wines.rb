class CreateWines < ActiveRecord::Migration
  def change
    create_table :wines do |t|
      t.string  :varietal
      t.string  :country
      t.integer :vintage
      t.string  :description
      t.integer :price

      t.timestamps
    end
  end
end
