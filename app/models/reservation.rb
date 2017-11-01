class Reservation < ApplicationRecord
	belongs_to :listing
	belongs_to :user
	validate :check_overlapping_dates
	validate :check_max_guests

	def check_overlapping_dates
		listing.reservations.each do |old_reservation|
		if overlap?(self, old_reservation)
			return errors.add(:overlapping_dates, "The booking dates conflict with exising bookings.")
		end	
	end	


	def overlap?(x,y)
		(x.start_date - y.end_date) * (y.start_date - x.end_date) > 0
	end

	def check_max_guests
		max_guest = listing.max_guest
		return if no_guest < max_guest
		errors.add(:max_guests, "Max guests number exceeded.")
		end	
	end

	def total_price
		price = listing.price
		num_dates = (start_date..end_date).to_a.length
		return price * num_dates
	end
end
