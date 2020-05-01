class Photo < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  has_many :organization, :through => :photo_receivers
  has_many :photo_receivers
  has_many :organizations, :through => :photo_receivers
  has_many :photo_comments

  belongs_to :photo_activity
  belongs_to :user, foreign_key: 'created_by'

  def file
    image.url
  end
end