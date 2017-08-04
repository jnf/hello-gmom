# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class RedirectsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'redirects'
  end
end
