class AddBackgroundColorToBlastMessage < ActiveRecord::Migration
  def change
    add_column :blast_messages, :background_color, :string
  end
end
