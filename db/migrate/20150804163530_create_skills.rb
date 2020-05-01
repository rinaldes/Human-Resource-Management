class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
    	t.integer :employee_id
    	t.string :skill_type
      t.timestamps
    end
  end
end
