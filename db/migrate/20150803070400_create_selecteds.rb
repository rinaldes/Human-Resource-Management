class CreateSelecteds < ActiveRecord::Migration
  def change
    create_table :selecteds do |t|
    	t.string :Aplicant_Name
    	t.string :Attachment
    	t.string :Apply_for_Position
    	t.string :Interview_Result
    	t.string :Status_Interview
      t.timestamps
    end
  end
end
