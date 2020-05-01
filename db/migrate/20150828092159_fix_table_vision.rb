class FixTableVision < ActiveRecord::Migration
  def change
  	# remove_column :visions, :content
  	rename_column :visions, :vision_ind, :content_ind
  	rename_column :visions, :vision_eng, :content_eng
  	#add_column :visions, :content_ind, :text
  	#add_column :visions, :content_eng, :text
  	#remove_column :visions, :language
  end
end
