class ChangeTypeDataContentCategory < ActiveRecord::Migration
  def change
  	change_column :knowledges, :content, :text
  
  end
end
