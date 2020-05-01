class CreateContactsNumbers < ActiveRecord::Migration
  def change
    create_table :contacts_numbers do |t|
      t.integer :home
      t.integer :handphone
      t.integer :office
      t.timestamps
    end
  end
end
