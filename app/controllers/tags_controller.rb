class TagsController < ApplicationController

	def new
		@tag = Tag.new
	end

	def create
		@tag = Tag.create(tag_params)
		redirect_to @tag
	end

	def show
		@tag = Tag.find(params[:id])
	end

	def tag_params
		params.require(:tag).permit(:content)
	end
end
