class RedirectsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'redirects'
  end
end
