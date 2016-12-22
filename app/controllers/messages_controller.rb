require './lib/assets/mms_decoder'

class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def incoming
    sender = Sender.from_number(params.fetch("From", nil))
    render xml: TWIML.unauthorized unless sender

    Message.create MmsDecoder.new(sender, params).to_h
    render xml: TWIML.thanks
  end
end
