class CreateCertifications < ActiveRecord::Migration
  def change
    create_table :certifications do |t|
    	t.integer :employee_id
			t.string :institution
			t.string :certification_number
			t.string :name_of_certification
    	t.date 	:date_of_certification
    	t.text :description
    	t.text :attachment
      t.timestamps
    end
  end
end
