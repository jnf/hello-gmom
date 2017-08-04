class RedirectsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def incoming
    sender = Sender.from_name(params.fetch("name", nil))

    # tell connected clients to redirect to the new stream
    ActionCable.server.broadcast 'redirects', to: show_sender_url(sender.name)

    render xml: TWIML.redirect
  rescue Exception => e
    puts e.inspect
    render xml: TWIML.error
  end
end
