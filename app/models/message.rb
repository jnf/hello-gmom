class Message < ApplicationRecord
  belongs_to :sender

  has_attached_file :image,
    styles: { medium: "400x400>", small: "200x200>" },
    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
