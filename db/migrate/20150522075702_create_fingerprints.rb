class CreateFingerprints < ActiveRecord::Migration
  def change
    create_table :fingerprints do |t|
    	t.string :name
    	t.string :ip_address
    	t.integer :port
      t.timestamps
    end
  end
end
