class CreateLeaveRequests < ActiveRecord::Migration
  def change
    create_table :leave_requests do |t|
    	t.string :name
    	t.date :start_date
    	t.date :end_date
    	t.string :reason
    	t.string :status
      t.timestamps
    end
  end
end
