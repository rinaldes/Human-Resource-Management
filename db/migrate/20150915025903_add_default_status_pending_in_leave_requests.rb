class AddDefaultStatusPendingInLeaveRequests < ActiveRecord::Migration
  def change
  	change_column :leave_requests, :status, :string, :default => "Pending"
  end
end
