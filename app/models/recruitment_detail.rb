class RecruitmentDetail < ActiveRecord::Base
	belongs_to :recruitment
	has_many :recruitment_skills
	belongs_to :organization
	belongs_to :position
	accepts_nested_attributes_for :recruitment_skills, :reject_if => :all_blank, :allow_destroy => true


	def range_age
		self.first_age.to_s + " - " + self.last_age.to_s
	end
	
end
