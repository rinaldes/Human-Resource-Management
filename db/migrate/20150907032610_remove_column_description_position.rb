class RemoveColumnDescriptionPosition < ActiveRecord::Migration
  def change
  	remove_column :positions, :description
  end
end
