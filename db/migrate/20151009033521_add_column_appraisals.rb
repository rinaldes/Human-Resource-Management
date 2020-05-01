class AddColumnAppraisals < ActiveRecord::Migration
  def change
 		add_column :appraisals, :goal, :string
 		add_column :appraisals, :value, :string
 		add_column :appraisals, :bobot2, :float
  end
end
