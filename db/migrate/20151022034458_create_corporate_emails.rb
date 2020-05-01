class CreateCorporateEmails < ActiveRecord::Migration
  def change
    create_table :corporate_emails do |t|
    	t.integer	:employee_id
    	t.string	:email
    	t.string	:password
      t.timestamps
    end
  end
end
