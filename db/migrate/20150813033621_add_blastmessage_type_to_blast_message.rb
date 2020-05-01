class AddBlastmessageTypeToBlastMessage < ActiveRecord::Migration
  def change
  	add_column :blast_messages, :blastmessage_type, :integer
  end
end
