class ApprovalLevelApprover < ActiveRecord::Base
	belongs_to :approval_level
	belongs_to :employee
	


end
