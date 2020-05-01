class AddArticelToKnowledge < ActiveRecord::Migration
  def change
  	add_column :knowledges, :content,:string
  end
end
