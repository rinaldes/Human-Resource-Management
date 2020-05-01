class RemoveColumnsType < ActiveRecord::Migration
  def self.up
  remove_column :blast_messages, :type
end
end
