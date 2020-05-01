class ChangeFieldAddressInformation < ActiveRecord::Migration
  def change
  	remove_column :address_informations, :provinsi
  	remove_column :address_informations, :kot_kab
  	remove_column :address_informations, :kec_kel
  	add_column :address_informations, :province_id, :integer 
  	add_column :address_informations, :city_id, :integer 
  	add_column :address_informations, :kecematan_id, :integer 
  end
end
