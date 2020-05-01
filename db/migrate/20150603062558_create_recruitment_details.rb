class CreateRecruitmentDetails < ActiveRecord::Migration
  def change
    create_table :recruitment_details do |t|
    	t.integer :recruitment_id
    	t.string :gender
    	t.string :age
    	t.integer :experience
    	t.boolean :fresh_graduate
    	t.text :skill
    	t.string :organization
    	t.string :position
      t.timestamps
    end
  end
end
