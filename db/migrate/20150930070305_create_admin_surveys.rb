class CreateAdminSurveys < ActiveRecord::Migration
  def change
    create_table :admin_surveys do |t|
    	t.string :question_title
      t.string :question_type
      t.string :status
      t.timestamps
    end
  end
end
