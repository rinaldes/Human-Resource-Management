class RenameComponentFieldAgain < ActiveRecord::Migration
  def change
  	rename_column :components, :component, :name
  end
end
