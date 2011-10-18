class ChangeDbFieldNames < ActiveRecord::Migration
  def up
    change_table :administrators do |t|
      t.rename :user_id, :user_code
    end
    change_table :post_votes do |t|
      t.rename :user_id, :user_code
    end
    change_table :posts do |t|
      t.rename :user_id, :user_code
    end
    change_table :replies do |t|
        t.rename :user_id, :user_code
      end
    change_table :reply_votes do |t|
        t.rename :user_id, :user_code
      end
    change_table :users do |t|
        t.rename :user_name, :user_code
    end
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
