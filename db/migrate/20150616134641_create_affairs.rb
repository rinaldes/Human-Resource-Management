class CreateAffairs < ActiveRecord::Migration
  def change
    create_table :affairs do |t|
      t.integer :nik
      t.date :start_work
      t.string :organization
      t.string :position
      t.integer :tax_status
      t.integer :no_npwp
      t.integer :no_id

      t.timestamps
    end
  end
end
