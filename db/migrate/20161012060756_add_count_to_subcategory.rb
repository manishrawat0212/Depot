class AddCountToSubcategory < ActiveRecord::Migration
  def change
    add_column :subcategories, :count, :integer
  end
end
