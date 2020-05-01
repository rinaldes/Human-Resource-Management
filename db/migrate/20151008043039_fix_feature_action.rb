class FixFeatureAction < ActiveRecord::Migration
  def change
  	rename_column :feature_actions, :feature_id, :feature_group_id
  end
end
