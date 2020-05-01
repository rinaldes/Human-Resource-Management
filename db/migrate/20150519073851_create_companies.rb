class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :visi
      t.string :misi
      t.string :culture
      t.string :code_ofconduct
      t.string :company_value
      t.time :delay_tolerance
      t.time :first_leave
      t.string :phone
      t.string :address
      t.string :province
      t.string :city
      t.string :postal_code
      t.string :owner_name
      t.string :com_email
      t.string :com_logo
      t.string :com_username
      t.string :com_password
      t.timestamps
    end
  end
end
