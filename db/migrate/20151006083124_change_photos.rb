class ChangePhotos < ActiveRecord::Migration
  def change
  	rename_column :photo_receivers, :organizations_id, :organization_id
  end
end
