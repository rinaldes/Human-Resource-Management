class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
    	t.integer :employee_id
    	t.string :contract_type
    	t.date :start
    	t.date :end
    	t.text :attachment
      t.timestamps
    end
  end
end
