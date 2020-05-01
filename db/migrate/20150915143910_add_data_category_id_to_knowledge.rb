class AddDataCategoryIdToKnowledge < ActiveRecord::Migration
  def change
  	add_column :knowledges, :category_id, :integer
  end
end
