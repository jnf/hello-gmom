class CreateSenders < ActiveRecord::Migration[5.0]
  def change
    create_table :senders do |t|
      t.string :number, index: true
      t.string :name
      t.timestamps
    end
  end
end
