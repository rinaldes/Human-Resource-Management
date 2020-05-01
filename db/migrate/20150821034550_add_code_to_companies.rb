class AddCodeToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :code, :integer
  end
end
