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
			redirect_to "/reservations/#{@reservation.id}/payment"
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

	def payment
		@reservation = Reservation.find(params[:id])
		@client_token = Braintree::ClientToken.generate
	end

	def checkout
		  nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
		  @reservation = Reservation.find(params[:id])
		  result = Braintree::Transaction.sale(
		   :amount => @reservation.total_price, #this is currently hardcoded
		   :payment_method_nonce => nonce_from_the_client,
		   :options => {
		      :submit_for_settlement => true
		    }
		   )

		  if result.success?
		    redirect_to current_user , :flash => { :success => "Transaction successful!" }
		  else
		    redirect_to @listings, :flash => { :error => "Transaction failed. Please try again." }
		  end
	end
		


	def reservation_params
		params.require(:reservation).permit(:start_date, :end_date, :no_guest)
	end
end


