class AddDefaultValueToCount < ActiveRecord::Migration
  def change
    change_column_null :categories, :count, false
    change_column_null :subcategories, :count, false

    change_column_default :categories, :count, from: nil, to: 0
    change_column_default :subcategories, :count, from: nil, to: 0
  end
end
