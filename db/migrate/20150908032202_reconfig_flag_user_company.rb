class ReconfigFlagUserCompany < ActiveRecord::Migration
  def change
  	remove_column :users, :flag_visi_misi
  	add_column :users, :flag_company_dashboard, :boolean, :default => true
  end
end
