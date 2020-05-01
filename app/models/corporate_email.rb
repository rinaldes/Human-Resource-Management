class CorporateEmail < ActiveRecord::Base
	belongs_to :employee
	validates :password, confirmation: true
  	validates :password_confirmation, presence: true
end
