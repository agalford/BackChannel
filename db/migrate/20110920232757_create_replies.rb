class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :reply_text
      t.integer :vote_count

      t.references :post
      t.references :user
      t.timestamps
    end
  end
end
