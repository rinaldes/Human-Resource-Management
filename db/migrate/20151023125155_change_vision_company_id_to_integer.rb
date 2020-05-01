class ChangeVisionCompanyIdToInteger < ActiveRecord::Migration
  def change
    change_column :visions, :company_id, :integer
  end
end
