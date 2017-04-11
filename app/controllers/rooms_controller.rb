class RoomsController < ApplicationController

	before_action :authenticate_user!

	# GET /rooms/1
	def show
		messages = Message.where(user_id: current_user.id)

		render json: messages
	end
 
end
