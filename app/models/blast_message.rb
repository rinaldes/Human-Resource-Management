class BlastMessage < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	has_many :employee
	has_many :organization
	has_many :blast_message_details
	belongs_to :user, foreign_key: :sender_id
	scope :first_level, -> { where("blastmessage_type=1 and created_at >= ?", Time.zone.now.beginning_of_day) }
	scope :second_level, -> { where("blastmessage_type=2 and created_at >= ?", Time.zone.now.beginning_of_day) }

  validate :check_message

  def check_message
    msg = message.split("img")
    errors.add(:message, "Message should contain text") if msg[0] == "<p><" && msg[1].split("/>")[1] == "</p>"
  end
end