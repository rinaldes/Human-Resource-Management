class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
    	t.integer :employee_id
    	t.string :home
    	t.string :phone
    	t.string :office
    	t.string :emergency_name
    	t.string :emergency_number
    	t.string :emergency_relation
      t.timestamps
    end
  end
end
