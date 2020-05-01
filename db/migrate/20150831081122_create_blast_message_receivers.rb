class CreateBlastMessageReceivers < ActiveRecord::Migration
  def change
    create_table :blast_message_receivers do |t|
    		t.integer :receiver_id
      		t.integer :blast_message_id	
      t.timestamps
    end
  end
end
