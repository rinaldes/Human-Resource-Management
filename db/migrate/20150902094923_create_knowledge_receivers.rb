class CreateKnowledgeReceivers < ActiveRecord::Migration
  def change
    create_table :knowledge_receivers do |t|
    t.integer :knowledge_id
    t.integer :category_id
      t.timestamps
    end
  end
end
