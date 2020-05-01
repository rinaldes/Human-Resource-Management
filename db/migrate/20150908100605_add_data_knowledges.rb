class AddDataKnowledges < ActiveRecord::Migration
  def change
    add_column :knowledges, :image_file_name, :string
    add_column :knowledges, :image_content_type, :string
    add_column :knowledges, :image_file_size, :string
    add_column :knowledges, :image_updated_at, :string
  end
end
