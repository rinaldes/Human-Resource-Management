class FixTableCultures < ActiveRecord::Migration
  def change
  	rename_column :cultures , :content , :content_ind
  	rename_column :cultures , :language , :content_eng
  	change_column :cultures , :content_eng , :text
  	change_column :cultures , :content_ind , :text
  end
end
