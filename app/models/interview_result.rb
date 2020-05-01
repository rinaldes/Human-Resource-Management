class InterviewResult < ActiveRecord::Base
	belongs_to :test_result
	belongs_to :recruitment
end
