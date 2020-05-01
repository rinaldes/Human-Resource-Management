class AddTypeToBlastMessages < ActiveRecord::Migration
  def change
  	add_column :blast_messages, :type, :integer
  end
end
