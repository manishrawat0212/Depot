class AddDefaultRating < ActiveRecord::Migration
  def change
	change_column_default :ratings, :rate, from: nil, to: 0
  end
end
