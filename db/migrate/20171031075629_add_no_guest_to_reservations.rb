class AddNoGuestToReservations < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :no_guest, :integer
  end
end
