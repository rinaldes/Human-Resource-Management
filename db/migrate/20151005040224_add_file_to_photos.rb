class AddFileToPhotos < ActiveRecord::Migration
  def change
  	add_column :photos, :histories, :text
  	add_column :photos, :organization_id, :integer
  	add_column :photos, :activity_id, :integer 
  end
end
