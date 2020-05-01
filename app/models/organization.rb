class Organization < ActiveRecord::Base
  has_many :photo, :through => :photo_receivers
  has_many :photo_receivers
  belongs_to :company
  has_many :employees
  has_many :recruitment
  has_many :recruitment_detail
end
