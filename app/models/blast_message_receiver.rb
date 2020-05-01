class BlastMessageReceiver < ActiveRecord::Base
	belongs_to :employee
	belongs_to :blast_message
end
