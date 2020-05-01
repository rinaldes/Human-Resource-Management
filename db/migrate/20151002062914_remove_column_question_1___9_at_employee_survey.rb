class RemoveColumnQuestion19AtEmployeeSurvey < ActiveRecord::Migration
  def change
  	remove_column :employee_surveys , :question_1
  	remove_column :employee_surveys , :question_2
  	remove_column :employee_surveys , :question_3
  	remove_column :employee_surveys , :question_4
  	remove_column :employee_surveys , :question_5
  	remove_column :employee_surveys , :question_6
  	remove_column :employee_surveys , :question_7
  	remove_column :employee_surveys , :question_8
  	remove_column :employee_surveys , :question_9
  	add_column :employee_surveys, :admin_survey_id, :integer
  	add_column :employee_surveys, :content_textbox, :string
  	add_column :employee_surveys, :content_textarea, :string
  	add_column :employee_surveys, :content_datepicker, :date
  end
end
