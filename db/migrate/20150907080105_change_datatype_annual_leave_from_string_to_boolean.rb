class ChangeDatatypeAnnualLeaveFromStringToBoolean < ActiveRecord::Migration
  def change
  	remove_column :holidays, :annual_leave
  end
end
