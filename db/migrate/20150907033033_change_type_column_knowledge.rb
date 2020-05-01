class ChangeTypeColumnKnowledge < ActiveRecord::Migration
  def change
  	change_column :knowledges, :image, :string
  end
end
