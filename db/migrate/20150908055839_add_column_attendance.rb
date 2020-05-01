class AddColumnAttendance < ActiveRecord::Migration
  def change
  	add_column :attendance_settings, :leave_reset, :integer
  end
end
