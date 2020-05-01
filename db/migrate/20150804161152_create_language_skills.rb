class CreateLanguageSkills < ActiveRecord::Migration
  def change
    create_table :language_skills do |t|
    	t.integer :employee_id
    	t.string :language
    	t.integer :reading
    	t.integer :writing
    	t.integer :speaking
      t.timestamps
    end
  end
end
