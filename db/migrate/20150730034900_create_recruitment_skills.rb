class CreateRecruitmentSkills < ActiveRecord::Migration
  def change
    create_table :recruitment_skills do |t|
    	t.integer :recruitment_detail_id
    	t.string :name
      t.timestamps
    end
  end
end
