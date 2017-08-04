Twilio.configure do |config|
  config.account_sid = ENV["TWILIO_ACCOUNT_SID"]
  config.auth_token = ENV["TWILIO_AUTH_TOKEN"]
end

TWIML = Value.new(:unauthorized, :thanks, :error, :redirect).with({
  unauthorized: "<?xml version=\"1.0\" encoding=\"UTF-8\" ?><Response><Message>403 Forbidden</Message><Message>I don't know you.</Message></Response>",
  thanks: "<?xml version=\"1.0\" encoding=\"UTF-8\" ?><Response><Message>200 Ok!</Message><Message>G'mom will see your message soon.</Message></Response>",
  error: "<?xml version=\"1.0\" encoding=\"UTF-8\" ?><Response><Message>500 Error. Something went wrong, but it's not your fault. Try again in a few minutes.</Message></Response>",
  redirect: "<?xml version=\"1.0\" encoding=\"UTF-8\" ?><Response><Message>200 OK</Message><Message>Clients Redirecting</Message></Response>"
})

class Twilio::UnauthorizedError < StandardError
  def initialize(msg = TWIML.unauthorized)
    super
  end
end
