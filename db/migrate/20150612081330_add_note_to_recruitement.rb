class AddNoteToRecruitement < ActiveRecord::Migration
  def change
  	add_column :recruitments, :note, :text
  end
end
