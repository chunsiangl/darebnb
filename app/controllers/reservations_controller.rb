class ReservationsController < ApplicationController
	def index
		@reservation = Reservation.new
		@listings = Listing.find(params[:listing_id])

	end

	def new
		@listings = Listing.find(params[:listing_id])
		@reservation = Reservation.new
	end

	def create
		@listings = Listing.find(params[:listing_id])
		@reservation = current_user.reservations.new(reservation_params)
		@reservation.listing = @listings
		if @reservation.save
			redirect_to current_user
		else
			@errors = @reservation.errors.full_messages
			render 'new'
		end
	end

	def show
		@reservation = Reservation.find(params[:id])
	end

	def destroy
		@reservation = Reservation.find(params[:id])
		@reservation.destroy
		redirect_to @reservation.user
	end

	def reservation_params
		params.require(:reservation).permit(:start_date, :end_date, :no_guest)
	end
end


