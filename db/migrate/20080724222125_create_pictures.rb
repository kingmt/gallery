class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.string :path
      t.text :description
      t.integer :album_id

      t.timestamps
    end
    
    add_index :pictures, :album_id
  end

  def self.down
    drop_table :pictures
  end
end
