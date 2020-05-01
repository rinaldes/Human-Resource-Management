class Appraisal < ActiveRecord::Base
	has_many :appraisal_components
	has_many :appraisal_values
	has_many :appraisal_goals
	belongs_to :employee
	accepts_nested_attributes_for :appraisal_components, :reject_if => :all_blank, :allow_destroy => true
end
