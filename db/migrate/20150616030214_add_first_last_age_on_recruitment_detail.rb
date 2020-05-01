class AddFirstLastAgeOnRecruitmentDetail < ActiveRecord::Migration
  def change
  	rename_column :recruitment_details, :age, :first_age
  	add_column :recruitment_details, :last_age, :integer
  end
end
