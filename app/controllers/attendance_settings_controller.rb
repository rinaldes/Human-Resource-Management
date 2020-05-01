class AttendanceSettingsController < ApplicationController
 def index
		@attendance_settings = AttendanceSetting.all
		begin
			@attend = AttendanceSetting.last.delay_tolerance2
		rescue
			@attend = 0
		end
		begin
			@attend2 = AttendanceSetting.last.leave_time2
		rescue
			@attend2 = 0
		end
		begin
			@leave_times = AttendanceSetting.last.leave_reset
		rescue
			@leave_times = 0
		end
		begin
			@appraisal_setting = AttendanceSetting.last.appraisal_setting
		rescue
			""
		end
		@attendance_setting = AttendanceSetting.new
	end
	def new

	end
	def create
		@attendance_setting = AttendanceSetting.new(attendance_settings_params)
		@attendance_setting.save
		redirect_to action: 'index'
	end
	private
		def attendance_settings_params
			params.require(:attendance_setting).permit(:delay_tolerance2, :leave_time2, :leave_time_other, :leave_reset, :appraisal_setting)
		end
end