class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :state
      t.string :city
      t.string :country
      t.integer :pincode
      t.references :user, index: true

      t.timestamps
    end
  end
end
