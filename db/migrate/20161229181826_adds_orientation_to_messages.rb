class AddsOrientationToMessages < ActiveRecord::Migration[5.0]
  def up
    add_column :messages, :orientation, :string

    # before_save hook will set the orientation for existing messages
    Message.all.map &:save
  end

  def down
    remove_column :messages, :orientation
  end
end
