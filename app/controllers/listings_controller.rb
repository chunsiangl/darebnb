class ListingsController < ApplicationController
  	def index
  		# @listings = Listing.all
  		@listings = Listing.order(:title).paginate(:page => params[:page], :per_page => 10)    
    end

    def show
      @listing = Listing.find(params[:id])
    	@listings = Listing.all
  # @listings = Listing.order('created_at DESC').page(params[:page]).per(15)
  		if params[:search]
    		@listings = Listing.search(params[:search])#.filter(params.slice(:address, :city, :country).order("created_at DESC")
  		else
    		@listings = []
  		end
  		 
  	end

  	def new
      @new_listing = Listing.new
      @user = current_user
      if @user.customer?
        redirect_to listings_path, flash:{notice: "Sorry. You are not allowed to perform this action."}
  		# return "/", notice: "Sorry. You do not have the permission to verify a property."
      else
        render :new
      end
    end

  	def create
  		@new_listing = Listing.new(listing_params)
  		@new_listing.save
  		@message = "New listing added."
  		render 'new'
  	end

    def verify
      @listing = Listing.find(params[:id])
      @listing.verify = true
      @listing.save
      #redirect_to @listing  #redirect to a objecct will go to the how path of that object  
    end

  	def listing_params
  		params.require(:listing).permit(:user_id, :title, :address, :city, :property_type, :no_bed, :no_bathroom, :max_guest, :description, :price)
  	end


end
