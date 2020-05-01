class AddIsActiveToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :is_active, :boolean, default: true
  end
end
