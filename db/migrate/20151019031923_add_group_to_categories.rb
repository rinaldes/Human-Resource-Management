class AddGroupToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :category_group, :string
  end
end
