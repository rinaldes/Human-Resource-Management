class CreatePhotoReceivers < ActiveRecord::Migration
  def change
    create_table :photo_receivers do |t|
    t.integer :photo_id
    t.integer :organizations_id
      t.timestamps
    end
  end
end
