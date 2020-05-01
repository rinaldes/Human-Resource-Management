class CreateKnowledgeComments < ActiveRecord::Migration
  def change
    create_table :knowledge_comments do |t|
    t.text :comment
    t.integer :knowledge_id
    t.integer :user_id

      t.timestamps
    end
  end
end
