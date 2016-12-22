class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def incoming
    render false
  end
end
