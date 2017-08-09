class DisplayController < ApplicationController
  def show
    @messages = Message.for_gmom
  end

  def by_sender
    sender = Sender.from_name(params.fetch(:sender, nil))

    # get all the messages from that sender
    @messages = sender.messages.for_gmom

    render :show
  end

  def weather; end
end
