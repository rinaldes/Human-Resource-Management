class FixTableCodeOfConducts < ActiveRecord::Migration
  def change
  	rename_column :code_of_conducts , :content , :content_ind
  	rename_column :code_of_conducts , :language , :content_eng
  	change_column :code_of_conducts , :content_eng , :text
  end
end
