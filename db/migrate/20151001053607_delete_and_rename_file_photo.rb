class DeleteAndRenameFilePhoto < ActiveRecord::Migration
  def change
  	
  	remove_column :photos, :file_content_type
  	remove_column :photos, :file_file_size
  	remove_column :photos, :file_updated_at

  	rename_column :photos, :file_file_name, :image
  end
end
