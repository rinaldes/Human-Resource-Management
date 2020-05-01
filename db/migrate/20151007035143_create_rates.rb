class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.integer :rate
      t.integer :user_id
      t.integer :knowledge_id
      t.timestamps
    end
  end
end
