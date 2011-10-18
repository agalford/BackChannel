class ChangeDbFieldNames2 < ActiveRecord::Migration
  def up
    change_table :administrators do |t|
      t.rename :user_code, :user_id
    end
    change_table :post_votes do |t|
      t.rename :user_code, :user_id
    end
    change_table :posts do |t|
      t.rename :user_code, :user_id
    end
    change_table :replies do |t|
        t.rename :user_code, :user_id
      end
    change_table :reply_votes do |t|
        t.rename :user_code, :user_id
      end
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
