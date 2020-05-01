class CreateAppraisalComponentIndikators < ActiveRecord::Migration
  def change
    create_table :appraisal_component_indikators do |t|
    	t.integer :appraisal_component_id
    	t.string :indikator
    	t.string :archivement
    	t.integer :score
      t.timestamps
    end
  end
end
