class AddColumnIndicatorDiComponent < ActiveRecord::Migration
  def change
  	add_column :components, :indicator, :string
  end
end
