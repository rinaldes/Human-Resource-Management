class AddColumnFlagVisiInUser < ActiveRecord::Migration
  def change
  	add_column :users, :flag_visi_misi, :boolean, :default => false
  end
end
