class CreateBlastMessageDetails < ActiveRecord::Migration
  def change
    create_table :blast_message_details do |t|
      t.integer :company_id
      t.integer :blast_message_id

      t.timestamps
    end
  end
end
