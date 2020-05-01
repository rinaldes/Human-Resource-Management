class DeleteAndRenameFileKnowledge < ActiveRecord::Migration
  def change
  	remove_column :knowledges, :image_content_type
  	remove_column :knowledges, :image_file_size
  	remove_column :knowledges, :image_updated_at

  	rename_column :knowledges, :image_file_name, :image
  end
end
