class AddColumnAppraisalToAttendanceSetting < ActiveRecord::Migration
  def change
  	add_column :attendance_settings, :appraisal, :string
	end
end
