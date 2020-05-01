class CreateFeatureGroups < ActiveRecord::Migration
  def change
    create_table :feature_groups do |t|
    	t.integer :feature_id
    	t.string :name
      t.timestamps
    end
  end
end
