class Sender < ApplicationRecord
  has_many :messages

  has_attached_file :avatar,
    path: ':rails_root/public/system/:class/:filename',
    url: '/system/:class/:filename',
    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  def self.from_number(number)
    where(number: number).first
  end
end
