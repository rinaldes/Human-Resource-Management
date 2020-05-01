class DeleteEmergencyKontakAndContactsNumber < ActiveRecord::Migration
  def change
  	drop_table :emergency_kontaks
  	drop_table :contacts_numbers
  end
end
