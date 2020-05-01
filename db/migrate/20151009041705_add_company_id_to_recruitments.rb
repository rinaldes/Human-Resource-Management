class AddCompanyIdToRecruitments < ActiveRecord::Migration
  def change
  	add_column :recruitments , :company_id , :integer
  end
end
