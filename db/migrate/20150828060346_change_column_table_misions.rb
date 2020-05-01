class ChangeColumnTableMisions < ActiveRecord::Migration
  def change
  	add_column :misions , :company_id , :integer
  	add_column :misions , :language , :string
  	rename_column :misions , :mision , :content
  end
end
