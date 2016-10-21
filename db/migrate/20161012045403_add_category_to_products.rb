class AddCategoryToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :category, polymorphic: true, index: true
  end
end
