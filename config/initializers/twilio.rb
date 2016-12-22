Twilio.configure do |config|
  config.account_sid = ENV["TWILIO_ACCOUNT_SID"]
  config.auth_token = ENV["TWILIO_AUTH_TOKEN"]
end

TWIML = Value.new(:unauthorized, :thanks).with({
  unauthorized: "<?xml version=\"1.0\" encoding=\"UTF-8\" ?><Response><Message>204 Unauthorized</Message></Response>",
  thanks: "<?xml version=\"1.0\" encoding=\"UTF-8\" ?><Response><Message>Ok! Your message is being processed!</Message></Response>"
})
