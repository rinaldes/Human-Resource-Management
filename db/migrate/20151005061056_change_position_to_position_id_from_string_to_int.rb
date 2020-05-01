class ChangePositionToPositionIdFromStringToInt < ActiveRecord::Migration
  def change
  	remove_column :test_results , :position , :string
  	add_column :test_results , :position_id , :integer
  end
end
