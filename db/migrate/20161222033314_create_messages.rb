class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.belongs_to :sender
      t.string :content_type
      t.string :body
      t.string :location
      t.timestamps
    end
  end
end
