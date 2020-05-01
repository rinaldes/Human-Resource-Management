class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
    	t.string :name
    	t.date :start
    	t.date :end
    	t.string :annual_leave
    	t.string :mandays

    	t.timestamps null: false
    end
  end
end
