class CreateFeatureActions < ActiveRecord::Migration
  def change
    create_table :feature_actions do |t|
    	t.integer :feature_id
    	t.string :action
      t.timestamps
    end
  end
end
