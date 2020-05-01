class ChangePhotoActivity < ActiveRecord::Migration
  def change
  	rename_column :photos, :activity_id, :photo_activity_id
  end
end
