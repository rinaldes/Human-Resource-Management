class AddColumnAnnualLeaveBoolean < ActiveRecord::Migration
  def change
  	add_column :holidays, :annual_leave, :boolean
  end
end
