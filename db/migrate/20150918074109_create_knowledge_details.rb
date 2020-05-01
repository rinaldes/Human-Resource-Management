class CreateKnowledgeDetails < ActiveRecord::Migration

  def change
    create_table :knowledge_details do |t|
		t.integer :knowledge_id
    	t.integer :user_id
    	t.boolean :status
      t.timestamps
    end
  end

end
