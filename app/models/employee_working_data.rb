class EmployeeWorkingData < ActiveRecord::Base
	belongs_to :employee
	#has_many :position_details
end
