class CreatePhotoComments < ActiveRecord::Migration
  def change
    create_table :photo_comments do |t|
    t.text :comment
    t.integer :photo_id
    t.integer :user_id
      t.timestamps
    end
  end
end
