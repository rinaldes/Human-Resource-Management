class CreateVisis < ActiveRecord::Migration
  def change
    create_table :visis do |t|
      t.string :visi
      t.timestamps
    end
  end
end
