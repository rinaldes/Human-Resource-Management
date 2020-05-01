class Recruitment < ActiveRecord::Base
	has_many :recruitment_details
	accepts_nested_attributes_for :recruitment_details, :reject_if => :all_blank, :allow_destroy => true
	has_many :test_results
	has_many :interview_results
	self.per_page = 5
  	belongs_to :organization
    def self.set_per_page(number)
      self.per_page = number
    end
    
end
