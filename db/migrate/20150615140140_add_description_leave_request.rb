class AddDescriptionLeaveRequest < ActiveRecord::Migration
  def change
  	add_column :leave_requests, :description, :text
  end
end
