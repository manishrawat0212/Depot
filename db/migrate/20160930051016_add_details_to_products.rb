class AddDetailsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :enabled, :boolean
    add_column :products, :discounted_price, :decimal
    add_column :products, :permalink, :string
    add_index :products, :permalink, unique: true
  end
end
