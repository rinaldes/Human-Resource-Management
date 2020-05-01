class AddEndDateToKnowledges < ActiveRecord::Migration
  def change
    add_column :knowledges, :end_date, :datetime
  end
end
