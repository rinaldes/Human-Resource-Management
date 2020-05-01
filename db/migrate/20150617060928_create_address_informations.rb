class CreateAddressInformations < ActiveRecord::Migration
  def change
    create_table :address_informations do |t|
      t.string :provinsi
      t.string :kot_kab
      t.string :kec_kel
      t.integer :rt
      t.integer :rw
      t.integer :kode_pos
      t.string :street

      t.timestamps
    end
  end
end
