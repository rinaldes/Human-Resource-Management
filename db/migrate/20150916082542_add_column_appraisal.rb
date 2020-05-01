class AddColumnAppraisal < ActiveRecord::Migration
  def change
  	add_column :appraisals, :start_period, :date
  	add_column :appraisals, :end_period, :date
  end
end
