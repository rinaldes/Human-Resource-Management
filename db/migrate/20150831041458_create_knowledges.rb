class CreateKnowledges < ActiveRecord::Migration
  def change
    create_table :knowledges do |t|
      t.string :article_name
      t.string :category
      t.string :status
      t.string :image
      t.timestamps
    end
  end
end
