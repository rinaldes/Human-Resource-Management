class AddColumnCompanyIdToKnowledges < ActiveRecord::Migration
  def change
  	add_column :knowledges, :company_id, :integer
  end
end
