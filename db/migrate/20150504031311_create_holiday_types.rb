class CreateHolidayTypes < ActiveRecord::Migration
  def change
    create_table :holiday_types do |t|
      t.string :code
      t.boolean :as_leave
      t.string :name
      t.timestamps
    end
  end
end
