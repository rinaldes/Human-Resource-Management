class RenameValueCompany < ActiveRecord::Migration
  def change
  	add_column :companies, :name, :string
  	rename_column :companies, :province, :province_id
  	rename_column :companies, :city, :city_id
  end
end
