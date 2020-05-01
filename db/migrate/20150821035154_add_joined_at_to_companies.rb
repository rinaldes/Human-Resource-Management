class AddJoinedAtToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :joined_at, :date
  end
end
