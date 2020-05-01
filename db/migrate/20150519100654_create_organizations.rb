class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
       t.integer :organization_parent
       t.integer :company_id
       t.string :name
       t.string :sub_org
       t.integer :total_employee
      t.timestamps
    end
  end
end
