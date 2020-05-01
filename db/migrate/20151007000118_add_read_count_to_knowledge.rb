class AddReadCountToKnowledge < ActiveRecord::Migration
  def change
    add_column :knowledges, :read_count, :integer
  end
end
