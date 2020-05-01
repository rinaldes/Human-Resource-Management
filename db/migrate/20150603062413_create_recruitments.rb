class CreateRecruitments < ActiveRecord::Migration
  def change
    create_table :recruitments do |t|
      t.integer :no_recruitment
      t.integer :user_id
      t.string :organization
      t.integer :man_power
      t.date :due_date
      t.string :status
      t.timestamps
    end
  end
end
