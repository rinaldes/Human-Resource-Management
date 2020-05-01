class CreateMisions < ActiveRecord::Migration
  def change
    create_table :misions do |t|
      t.string :mision
      t.timestamps
    end
  end
end
