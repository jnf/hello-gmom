require './lib/assets/mms_decoder'

class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def incoming
    sender = Sender.from_number(params.fetch("From", nil))
    raise Twilio::UnauthorizedError unless sender

    # create the message
    message = Message.create! MmsDecoder.new(sender, params).to_h

    # tell gmom about it
    ActionCable.server.broadcast 'messages',
      message: message.for_client,
      sender: message.sender.for_client

    # let the sender know she got it
    render xml: TWIML.thanks
  rescue Twilio::UnauthorizedError # lolnope
    render xml: TWIML.unauthorized
  rescue Exception => e # :(
    puts e.inspect # I should know about this
    render xml: TWIML.error
  end
end
