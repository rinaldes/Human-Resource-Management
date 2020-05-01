class CreateEmployeeSurveys < ActiveRecord::Migration
  def change
    create_table :employee_surveys do |t|
      t.integer :employee_id
      t.string :question_1
      t.string :question_2
      t.string :question_3
      t.string :question_4
      t.string :question_5
      t.string :question_6
      t.string :question_7
      t.string :question_8
      t.string :question_9
      t.timestamps
    end
  end
end
