class AddLineItemsCountToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :line_item_count, :integer, null: false, default: 0
  end
end
