Demo chat for Rails 5 API-only using ActionCable and Devise Authentication.

http://stackoverflow.com/questions/39741120/how-to-use-devise-token-auth-with-actioncable-for-authenticating-user/43278860#43278860

----------------------------------

If using sideway client (e.g. Simple Web Socket Client for Google Chrome):

1. Sign in via HTTP as:

POST http://localhost:3000/api/auth/sign_in?email=client1@example.com&password=12345678

You'll get back these headers:

access-token: BndOS3qh9zJF4Nc4cfOFDA
client: MhTwe4aEftJzOFv0dbO8Qg
uid: client1@example.com

Use these headers for Basic Websockets Authorisation:

2. Connect: ws://localhost:3000/cable/?access-token=BndOS3qh9zJF4Nc4cfOFDA&client=MhTwe4aEftJzOFv0dbO8Qg&uid=client1@example.com

3. Subscribe: {"command":"subscribe","identifier":"{\"channel\":\"RoomChannel\",\"access-token\":\"BndOS3qh9zJF4Nc4cfOFDA\",\"client\":\"MhTwe4aEftJzOFv0dbO8Qg\",\"uid\":\"client1@example.com\"}"}

4. Send message: {"command":"message","identifier":"{\"channel\":\"RoomChannel\",\"access-token\":\"BndOS3qh9zJF4Nc4cfOFDA\",\"client\":\"MhTwe4aEftJzOFv0dbO8Qg\",\"uid\":\"client1@example.com\"}","data":"{\"name\":\"debug\",\"content\":\"debug\",\"action\":\"process_message_on_server\"}"}