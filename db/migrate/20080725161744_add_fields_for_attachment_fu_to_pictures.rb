class AddFieldsForAttachmentFuToPictures < ActiveRecord::Migration
  def self.up
    add_column :pictures, :size, :integer
    add_column :pictures, :content_type, :string
    add_column :pictures, :filename, :string
    add_column :pictures, :height, :integer
    add_column :pictures, :width, :integer
    add_column :pictures, :parent_id, :integer
    add_column :pictures, :thumbnail, :string
    remove_column :pictures, :path
  end

  def self.down
    remove_column :pictures, :thumbnail
    remove_column :pictures, :parent_id
    remove_column :pictures, :width
    remove_column :pictures, :height
    remove_column :pictures, :filename
    remove_column :pictures, :content_type
    remove_column :pictures, :size
    add_column :pictures, :path, :string
  end
end
