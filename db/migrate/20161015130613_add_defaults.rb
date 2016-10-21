class AddDefaults < ActiveRecord::Migration
  def change
    change_column_default :categories, :count, 0
    change_column_default :subcategories, :count, 0
    change_column_default :products, :enabled, false
  end
end
