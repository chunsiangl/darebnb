class ListingsController < ApplicationController
  	def index
  		@listings = Listing.order(:title).paginate(:page => params[:page], :per_page => 10)
          
    end

    def show
     
    	@listings = Listing.find(params[:id])
      @reservations = @listings.reservations.new
  		 
  	end


    def search
      if params[:search]
        @listings = Listing.search(params[:search])
        @listings = @listings.order(:title).paginate(:page => params[:page], :per_page => 10)
      end
    end


  	def new
      @new_listing = Listing.new
      @user = current_user
    #   if @user.customer?
    #     redirect_to listings_path, flash:{notice: "Sorry. You are not allowed to perform this action."}
  		# # return "/", notice: "Sorry. You do not have the permission to verify a property."
    #   else
    #     render :new
    #   end
    end


    def edit
        @listings = Listing.find(params[:id])  
    end


    def update
      @listings = Listing.find(params[:id])
        if @listings.update(listing_params)
           @message = "Listing updated."
        end
      @user = current_user
      redirect_to @user
    end

  	def create
  		@new_listing = Listing.new(listing_params)
  		@new_listing.save
  		@message = "New listing added."
  		render 'new'
  	end

    def destroy
      @listings = Listing.find(params[:id])
      @listings.destroy
      redirect_to @listings.user
    end


    def verify
      if current_user.moderator?
        @listing = Listing.find(params[:id])
        @listing.verify = true
        @listing.save
      end
      #redirect_to @listing  #redirect to a objecct will go to the how path of that object  
    end

  	def listing_params
  		params.require(:listing).permit(:user_id, :title, :address, :city, :property_type, :no_bed, :no_bathroom, :max_guest, :description, :price, {photos: []})
  	end


end
