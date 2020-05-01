class AddRecruitmentid < ActiveRecord::Migration
  def change
  	add_column :test_results, :recruitment_id, :string
  end
end
