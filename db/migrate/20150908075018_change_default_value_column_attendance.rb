class ChangeDefaultValueColumnAttendance < ActiveRecord::Migration
  def change
  	change_column :attendance_settings, :leave_time2, :integer, :default => "0"
  end
end
