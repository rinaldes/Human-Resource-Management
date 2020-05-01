class AddEmailAndCvStatusOnTestResults < ActiveRecord::Migration
  def change
  	add_column :test_results , :email , :string
  	add_column :test_results , :cv_status , :string
  end
end
