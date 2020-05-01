class CreateFlagCompanies < ActiveRecord::Migration
  def change
    create_table :flag_companies do |t|
    	t.integer :user_id
    	t.boolean :vision, default: true
    	t.boolean :mision, default: true
    	t.boolean :code_of_conduct, default: true
    	t.boolean :value_company, default: true
    	t.boolean :culture, default: true
      t.timestamps
    end
  end
end
