class ChangeColumnPosition < ActiveRecord::Migration
  def change
  	remove_column :positions, :leave_time
  	add_column :positions, :leave_time, :integer
  end
end
