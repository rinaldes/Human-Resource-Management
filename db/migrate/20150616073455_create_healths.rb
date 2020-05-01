class CreateHealths < ActiveRecord::Migration
  def change
    create_table :healths do |t|
      t.string :color_blind
      t.string :blood_type
      t.integer :height
      t.integer :weight
      t.text :history
      t.string :health_benefit

      t.timestamps
    end
  end
end
