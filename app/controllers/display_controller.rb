class DisplayController < ApplicationController
  def show
    @messages = Message.for_gmom
  end
end
