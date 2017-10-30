class UsersController < ApplicationController
	def index
		
	end

	def show
		@user = User.find(params[:id])
		@listings = Listing.where(user_id: current_user.id)
		
	end

	def edit
		@user = User.find(params[:id])	
	end

	def update
    @user = User.find(params[:id])
        if @user.update(user_params)
        	@message = "Profile updated."
        else
        	@message = "Please login first."
   		end
   		render 'show'
   	end

    def destroy
    @user = User.find(params[:id])
    @user.destroy
      redirect_to user_index_path
  	end

private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password)
    end

end



