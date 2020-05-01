class RemoveStatusToKnowledgeDetails < ActiveRecord::Migration
  def change
  	remove_column :knowledge_details, :status
  	add_column :knowledge_details, :status, :boolean, :default => false
  end
end
