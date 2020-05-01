class AddColumnAbsence < ActiveRecord::Migration
  def change
  	add_column :absences, :status, :string
  	add_column :absences, :reason, :string
  end
end
