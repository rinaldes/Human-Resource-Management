class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :company_id
      t.integer :shift_id
      t.date    :start_period
      t.date    :end_period
      t.timestamps
    end
  end
end
