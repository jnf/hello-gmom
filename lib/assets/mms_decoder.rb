# frozen_string_literal: true

require 'open-uri'
require 'values'

class MmsDecoder
  attr_reader :data, :message

  VALID_PARAMS = [
    "MediaContentType0", "MediaUrl0", "Body",
    "FromCity", "FromState", "FromCountry"
  ].freeze

  MESSAGE = Value.new(:sender, :body, :location, :image)

  def initialize(sender, params)
    @data    = filter_params params
    @message = MESSAGE.with(
      sender: sender,
      body: data.fetch("Body", ''),
      location: build_location,
      image: build_image
    )
  end

  def to_h
    message.to_h
  end

  protected

  def build_image
    path = data.fetch('MediaUrl0', nil)
    path && URI.parse(path)
  end

  def build_location
    ["FromCity", "FromState", "FromCountry"].map { |k| data.fetch(k, nil) }
      .compact
      .join(', ')
  end

  def filter_params(params)
    params.select { |param| VALID_PARAMS.member? param }
  end
end
