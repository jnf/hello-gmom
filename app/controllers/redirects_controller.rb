class RedirectsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def incoming
    sender = Sender.from_name(params.fetch("name", nil))
    path = sender ? show_sender_url(sender.name) : root_url

    # tell connected clients to redirect to the new stream
    ActionCable.server.broadcast 'redirects', to: path

    render xml: TWIML.redirect
  rescue Exception => e
    puts e.inspect
    render xml: TWIML.error
  end
end
