class CreateIndicators < ActiveRecord::Migration
  def change
    create_table :indicators do |t|
    	t.string :name
    	t.integer :component_id
      t.timestamps
    end
    rename_column :components, :indikator, :indicators
  end
end
