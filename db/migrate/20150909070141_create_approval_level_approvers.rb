class CreateApprovalLevelApprovers < ActiveRecord::Migration
  def change
    create_table :approval_level_approvers do |t|
    	t.integer :approval_level_id
    	t.integer :user_id
      t.timestamps
    end
  end
end
