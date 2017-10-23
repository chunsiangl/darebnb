class ListingsController < ApplicationController
	def index
  			@listings = Listing.all
  		if params[:search]
    		@listings = Listing.search(params[:search]).order("created_at DESC")
  		else
    		@listings = Listings.all.order('created_at DESC')
  		end
    end


end
