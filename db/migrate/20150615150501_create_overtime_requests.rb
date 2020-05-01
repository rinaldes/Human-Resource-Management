class CreateOvertimeRequests < ActiveRecord::Migration
  def change
    create_table :overtime_requests do |t|
    	t.string :name
    	t.date :date
    	t.time :start_time
    	t.time :end_time
    	t.string :reason
      t.timestamps
    end
  end
end
