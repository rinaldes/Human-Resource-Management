class RemoveDataKnowledge < ActiveRecord::Migration
  def change
  	remove_column :knowledges, :category_id
  	remove_column :knowledges, :image
  end
end
