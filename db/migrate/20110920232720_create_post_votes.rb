class CreatePostVotes < ActiveRecord::Migration
  def change
    create_table :post_votes do |t|
      t.references :post
      t.references :user

      t.timestamps
    end
  end
end
