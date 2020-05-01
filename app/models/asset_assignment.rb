class AssetAssignment < ActiveRecord::Base
	belongs_to :employee
	has_many :asset_assignment_details
	accepts_nested_attributes_for :asset_assignment_details, :reject_if => :all_blank, :allow_destroy => true


	def count_assets
		self.asset_assignment_details.count
	end

	def count_returned_assets
		self.asset_assignment_details.where(:returned => true).count
	end
end
