class AddPublishDateToKnowledge < ActiveRecord::Migration
  def change
    add_column :knowledges, :publish_date, :datetime
  end
end
