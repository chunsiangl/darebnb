class RemoveReservationIdFromListing < ActiveRecord::Migration[5.1]
  def change
    remove_column :listings, :reservation_id, :integer
  end
end
