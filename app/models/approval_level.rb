class ApprovalLevel < ActiveRecord::Base
	belongs_to :company
	has_many :approval_level_approvers
	accepts_nested_attributes_for :approval_level_approvers, :reject_if => :all_blank, :allow_destroy => true
end
