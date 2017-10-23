class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.integer :user_id
      t.integer :reservation_id
      t.string :address
      t.string :city
      t.string :country
      t.string :property_type
      t.integer :no_bed
      t.integer :no_bathroom
      t.integer :max_guest
      t.string :description
      t.string :review
      t.integer :price
      t.integer :rating

      t.timestamps
    end
  end
end
