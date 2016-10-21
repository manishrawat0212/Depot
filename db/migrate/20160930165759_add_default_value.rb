class AddDefaultValue < ActiveRecord::Migration
  def change
	change_column_default :products, :enabled, from: nil, to: false
  end
end
