class EditTableRecruitmentDetails < ActiveRecord::Migration
  def change
  	remove_column :recruitment_details , :organization , :string
  	remove_column :recruitment_details , :position , :string
  	add_column :recruitment_details , :organization_id , :integer
  	add_column :recruitment_details , :position_id , :integer
  end
end
