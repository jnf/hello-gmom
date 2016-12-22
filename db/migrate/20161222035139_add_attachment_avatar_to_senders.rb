class AddAttachmentAvatarToSenders < ActiveRecord::Migration
  def self.up
    change_table :senders do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :senders, :avatar
  end
end
