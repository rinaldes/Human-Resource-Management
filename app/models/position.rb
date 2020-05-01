class Position < ActiveRecord::Base
	has_many :recruitment_detail
	has_many :test_result
end
