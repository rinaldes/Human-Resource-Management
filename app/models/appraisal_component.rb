class AppraisalComponent < ActiveRecord::Base
	belongs_to :appraisal
	has_many :appraisal_component_indikators
	accepts_nested_attributes_for :appraisal_component_indikators, :reject_if => :all_blank, :allow_destroy => true
end
