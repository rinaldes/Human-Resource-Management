class TestResult < ActiveRecord::Base
mount_uploader :attachment, AttachmentUploader
has_one :interview_result , :dependent => :destroy
belongs_to :recruitment
belongs_to :position
end
