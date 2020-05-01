class BlastMessageDetail < ActiveRecord::Base
	belongs_to :company
	belongs_to :employee
	belongs_to :division
	belongs_to :blast_message
	# after_create :send_mail


	
end
