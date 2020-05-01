class ChangeAprrovaerStucture < ActiveRecord::Migration
  def change
  	rename_column :approval_level_approvers, :user_id, :employee_id
  end
end
