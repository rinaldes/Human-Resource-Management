class FeatureGroup < ActiveRecord::Base
	belongs_to :feature
	has_many :feature_actions, dependent: :destroy
end
