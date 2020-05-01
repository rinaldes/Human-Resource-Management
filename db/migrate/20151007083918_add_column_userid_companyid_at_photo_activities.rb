class AddColumnUseridCompanyidAtPhotoActivities < ActiveRecord::Migration
  def change
  	add_column :photo_activities, :company_id, :integer
  	add_column :photo_activities, :user_id, :integer
  end
end
