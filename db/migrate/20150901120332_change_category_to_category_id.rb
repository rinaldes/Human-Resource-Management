class ChangeCategoryToCategoryId < ActiveRecord::Migration
  def change
  	rename_column :knowledges, :category, :category_id
  	change_column :knowledges, :category_id, 'integer USING CAST(category_id as integer)'

  end
end
