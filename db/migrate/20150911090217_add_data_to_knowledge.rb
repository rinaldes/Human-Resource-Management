class AddDataToKnowledge < ActiveRecord::Migration
  def change
  	add_column :knowledges, :user_id, :integer
  	remove_column :knowledges, :status
  	add_column :knowledges, :status, :boolean
  end
end
