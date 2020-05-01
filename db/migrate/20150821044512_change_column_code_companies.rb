class ChangeColumnCodeCompanies < ActiveRecord::Migration
  def up
  	change_column :companies, :code, :string
  end

  def down
  	change_column :companies, :code, :integer
  end
end
