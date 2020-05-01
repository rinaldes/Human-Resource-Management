class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
    	t.integer :employee_id
    	t.string :status
    	t.string :name
    	t.string :address
    	t.string :education
    	t.string :work
    	t.date :birthday
      t.timestamps
    end
  end
end
