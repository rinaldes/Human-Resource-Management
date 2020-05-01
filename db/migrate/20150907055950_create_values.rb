class CreateValues < ActiveRecord::Migration
  def change
    create_table :values do |t|
    	t.integer :company_id
    	t.text :content_ind
    	t.text :content_eng
      t.timestamps
    end
  end
end
