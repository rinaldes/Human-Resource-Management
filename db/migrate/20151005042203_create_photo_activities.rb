class CreatePhotoActivities < ActiveRecord::Migration
  def change
    create_table :photo_activities do |t|
    t.string :name
      t.timestamps
    end
  end
end
