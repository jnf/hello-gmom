class RedirectsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def incoming
    sender = Sender.from_name(params.fetch("name", 'nobody'))
    path = sender ? show_sender_url(sender.name) : show_url

    # tell connected clients to redirect to the new stream
    ActionCable.server.broadcast 'redirects',
      action: :redirect,
      to: path

    render xml: TWIML.redirect
  rescue Exception => e
    puts e.inspect
    render xml: TWIML.error
  end
end
