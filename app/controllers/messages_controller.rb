require './lib/assets/mms_decoder'

class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def incoming
    sender = Sender.from_number(params.fetch("From", nil))
    raise Twilio::UnauthorizedError unless sender

    Message.create MmsDecoder.new(sender, params).to_h
    render xml: TWIML.thanks
  rescue Twilio::UnauthorizedError
    render xml: TWIML.unauthorized
  rescue Exception
    render xml: TWIML.error
  end
end
