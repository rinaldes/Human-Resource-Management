class AddColumnAttendanceSetting < ActiveRecord::Migration
  def change
  	add_column :attendance_settings, :appraisal_setting, :string
  end
end
