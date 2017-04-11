# https://www.pluralsight.com/guides/ruby-ruby-on-rails/creating-a-chat-using-rails-action-cable
class RoomChannel < ApplicationCable::Channel
  def subscribed

    access_token = params["access-token"]
    uid = params["uid"]
    client = params["client"]

    user = User.find_by email: uid

    if user && user.valid_token?(access_token, client)

      stream_from "room_#{params['access-token']}_channel"

    else
# http://api.rubyonrails.org/classes/ActionCable/Channel/Base.html#class-ActionCable::Channel::Base-label-Rejecting+subscription+requests
      reject

    end

  end
 
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
 
  def process_message_on_server(param_message)

    message = current_user.messages.create!(name: param_message['name'], content: param_message['content'])

    # DEBUG:
    # message = Message.new name: param_message['name'], content: param_message['content']

    ActionCable.server.broadcast "room_#{params['access-token']}_channel",
                                 message: message                          

  end
end
