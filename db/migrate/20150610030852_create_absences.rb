class CreateAbsences < ActiveRecord::Migration
  def change
    create_table :absences do |t|
    	t.string :name
    	t.string :organization
    	t.string :shift
    	t.date :date
    	t.time :check_in
    	t.time :check_out
    	t.string :overtime
      t.timestamps
    end
  end
end
