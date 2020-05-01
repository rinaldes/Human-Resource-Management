class AddCreatedByAndUpdatedByToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :created_by, :integer
    add_column :photos, :updated_by, :integer
  end
end
