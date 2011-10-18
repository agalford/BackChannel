class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :post_text
      t.integer :vote_count

      t.references :user
      t.timestamps
    end
  end
end
