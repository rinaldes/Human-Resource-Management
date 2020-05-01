class FixTableMisions < ActiveRecord::Migration
  def change
  	rename_column :misions , :content , :content_ind
  	rename_column :misions , :language , :content_eng
  	change_column :misions , :content_eng , :text
  	change_column :misions , :content_ind , :text
  end
end
