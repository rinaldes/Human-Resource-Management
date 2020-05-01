class CreateAttendanceSettings < ActiveRecord::Migration
  def change
    create_table :attendance_settings do |t|
      t.time :delay_tolerance
      t.date :leave_time
      t.timestamps
    end
  end
end
