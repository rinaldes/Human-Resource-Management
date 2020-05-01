class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
    	t.string :component
    	t.string :indikator
      t.timestamps
    end
  end
end
