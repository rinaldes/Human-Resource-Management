class Shift < ActiveRecord::Base
	has_many :schedules
	has_many :employees
end
