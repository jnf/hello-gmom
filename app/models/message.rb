class Message < ApplicationRecord
  FOR_CLIENT_PARAMS = Value.new(:body, :location, :image, :created_at, :orientation)
  belongs_to :sender

  has_attached_file :image,
    path: ':rails_root/public/system/:class/:id.:extension',
    url: '/system/:class/:id.:extension',
    styles: { original: ["1500x1500>", :jpg] }

  validates :sender, presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  before_save :define_orientation

  scope :has_body, -> { where.not(body: nil) }

  def self.for_gmom
    self.includes(:sender).has_body.order(created_at: :desc).limit(50)
  end

  def for_client
    FOR_CLIENT_PARAMS.with ({
      body: body,
      location: location,
      image: image? ? image.url : nil,
      created_at: created_at.localtime.to_s(:normal),
      orientation: image? ? orientation : ''
    })
  end

  private

  def define_orientation
    return unless image?

    file = image.queued_for_write[:original] || image
    geo = Paperclip::Geometry.from_file(file.path)
    self.orientation = %w(vertical horizontal square).find do |orientation|
      geo.send orientation + '?'
    end
  end
end
