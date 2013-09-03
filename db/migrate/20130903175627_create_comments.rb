class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :user_id
      t.integer :wine_id

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :wine_id
  end
end
