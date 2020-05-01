class CreateCultures < ActiveRecord::Migration
  def change
    create_table :cultures do |t|
    	t.integer :company_id
    	t.string :content
    	t.string :language
      t.timestamps
    end
  end
end
