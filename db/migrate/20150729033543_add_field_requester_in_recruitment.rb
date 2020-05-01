class AddFieldRequesterInRecruitment < ActiveRecord::Migration
  def change
  	add_column :recruitments, :requester, :string
  end
end
