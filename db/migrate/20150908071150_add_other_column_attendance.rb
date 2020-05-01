class AddOtherColumnAttendance < ActiveRecord::Migration
  def change
  	add_column :attendance_settings, :leave_time2, :integer
  	add_column :attendance_settings, :delay_tolerance2, :integer
  end
end
