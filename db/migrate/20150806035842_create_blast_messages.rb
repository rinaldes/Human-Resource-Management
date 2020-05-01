class CreateBlastMessages < ActiveRecord::Migration
  def change
    create_table :blast_messages do |t|
    	t.string :email
    	t.text	 :message
      t.timestamps
    end
  end
end
