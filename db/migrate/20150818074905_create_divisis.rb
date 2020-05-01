class CreateDivisis < ActiveRecord::Migration
  def change
    create_table :divisis do |t|
    	t.string :divisi_id
      	t.string :name
      	t.timestamps
    end
  end
end
