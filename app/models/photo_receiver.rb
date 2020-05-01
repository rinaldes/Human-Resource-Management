class PhotoReceiver < ActiveRecord::Base
	belongs_to :organization
	belongs_to :photo
	
end
