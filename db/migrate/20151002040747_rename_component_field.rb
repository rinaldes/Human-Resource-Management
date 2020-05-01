class RenameComponentField < ActiveRecord::Migration
  def change
  	rename_column :components, :name, :component
  end
end
