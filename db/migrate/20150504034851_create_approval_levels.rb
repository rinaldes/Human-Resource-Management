class CreateApprovalLevels < ActiveRecord::Migration
  def change
    create_table :approval_levels do |t|
      t.integer :user_id 
      t.integer :features_id
      t.timestamps
    end
  end
end
