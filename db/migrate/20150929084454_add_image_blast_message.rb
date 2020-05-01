class AddImageBlastMessage < ActiveRecord::Migration
  def change
  	add_column :blast_messages, :image, :string
  end
end
