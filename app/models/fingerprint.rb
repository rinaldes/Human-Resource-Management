class Fingerprint < ActiveRecord::Base
	validates :name, presence: true
	validates :ip_address, presence: true, :format => { :with => Regexp.union(Resolv::IPv4::Regex, Resolv::IPv6::Regex)}
	validates :port, presence: true
	self.per_page = 5
	
	def self.set_per_page(number)
    	self.per_page = number
    end
end
