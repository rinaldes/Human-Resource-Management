class ChangeTypeDataHealth < ActiveRecord::Migration
  def change
  	remove_column :healths, :color_blind
  	add_column :healths, :color_blind, :boolean

  end
end
