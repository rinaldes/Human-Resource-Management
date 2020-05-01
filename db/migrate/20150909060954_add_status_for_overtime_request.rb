class AddStatusForOvertimeRequest < ActiveRecord::Migration
  def change
  	add_column :overtime_requests, :status, :string
  end
end
