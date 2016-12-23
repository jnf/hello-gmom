class Message < ApplicationRecord
  belongs_to :sender

  has_attached_file :image,
    path: ':rails_root/public/system/:class/:id.:extension',
    styles: { original: ["1500x1500>", :jpg] },
    default_url: "/images/:style/missing.png"

  validates :sender, presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def self.for_gmom
    self.includes(:sender).order(created_at: :desc).limit(25)
  end
end
