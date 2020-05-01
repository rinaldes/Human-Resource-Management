class AddCreatedByToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :created_by, :integer
    add_column :categories, :updated_by, :integer
  end
end
