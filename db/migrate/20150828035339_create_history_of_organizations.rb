class CreateHistoryOfOrganizations < ActiveRecord::Migration
  def change
    create_table :history_of_organizations do |t|
    	t.integer :employee_id
			t.string :name
			t.string :phone_number
			t.string :position
			t.string :statue
    	t.date 	:start
    	t.date :end
      t.timestamps
    end
  end
end
