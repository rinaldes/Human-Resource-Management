class ScheduleDetail < ActiveRecord::Base
	belongs_to :schedule
	belongs_to :employee
end
