class DeleteColumnIndicators < ActiveRecord::Migration
  def change
  	remove_column :components, :indicators
  end
end
