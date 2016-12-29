class Message < ApplicationRecord
  FOR_CLIENT_PARAMS = Value.new(:body, :location, :image, :created_at)
  belongs_to :sender

  has_attached_file :image,
    path: ':rails_root/public/system/:class/:id.:extension',
    url: '/system/:class/:id.:extension',
    styles: { original: ["1500x1500>", :jpg] }

  validates :sender, presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  before_save :define_orientation

  def self.for_gmom
    self.includes(:sender).order(created_at: :desc).limit(25)
  end

  def for_client
    FOR_CLIENT_PARAMS.with ({
      body: body,
      location: location,
      image: image? ? image.url : nil,
      created_at: created_at.localtime.to_s(:normal)
    })
  end

  private

  def define_orientation
    return unless image?
    geo = Paperclip::Geometry.from_file(image)
    self.orientation = %w(vertical horizontal square).find do |orientation|
      geo.send orientation + '?'
    end
  end
end
