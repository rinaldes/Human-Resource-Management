class DefaultValueStatusForImportOvertimeRequest < ActiveRecord::Migration
  def change
  	change_column :overtime_requests, :status, :string, :default => "Pending"
  end
end
