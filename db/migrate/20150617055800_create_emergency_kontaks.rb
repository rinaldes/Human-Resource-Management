class CreateEmergencyKontaks < ActiveRecord::Migration
  def change
    create_table :emergency_kontaks do |t|
      t.string :name
      t.integer :phone_number
      t.string :relationship
     
      t.timestamps
    end
  end
end
