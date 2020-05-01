class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.integer :nik
      t.string :name
      t.string :status
      t.date :duedate
      t.string :organization
      t.string :position
      t.string :shift

      t.timestamps
    end
  end
end
