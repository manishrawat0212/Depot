class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.decimal :rate, precision: 3, scale: 1
      t.references :product, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
