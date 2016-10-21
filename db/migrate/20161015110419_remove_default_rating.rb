class RemoveDefaultRating < ActiveRecord::Migration
  def change
	change_column_default :ratings, :rate, 00
  end
end
