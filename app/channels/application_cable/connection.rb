# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
module ApplicationCable
  class Connection < ActionCable::Connection::Base
	identified_by :current_user

	def connect
# ws://localhost:3000/cable/?access-token=zZ12GuNyGYR5HM7yhYwPpg&client=Fgp76lGbk3xmqCzhBy1DbQ&uid=client1@example.com		

		params = request.query_parameters()

		access_token = params["access-token"]
		uid = params["uid"]
		client = params["client"]

		self.current_user = find_verified_user access_token, uid, client
		logger.add_tags 'ActionCable', current_user.email
	end


    protected

		def find_verified_user token, uid, client_id # this checks whether a user is authenticated with devise

			user = User.find_by email: uid

			if user && user.valid_token?(token, client_id)
				user
			else
				reject_unauthorized_connection
			end
	    end   
  end
end
