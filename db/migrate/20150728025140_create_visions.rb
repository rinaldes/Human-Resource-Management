class CreateVisions < ActiveRecord::Migration
  def change
    create_table :visions do |t|
    	 t.integer :company_id
    	 t.string :content
    	 t.string :language
       t.timestamps
    end
  end
end
