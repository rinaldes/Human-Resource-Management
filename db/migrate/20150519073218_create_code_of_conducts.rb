class CreateCodeOfConducts < ActiveRecord::Migration
  def change
    create_table :code_of_conducts do |t|
      t.string :language
      t.text :content
      t.integer :company_id
      t.timestamps
    end
  end
end
