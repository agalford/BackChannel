class AddUniqueConstraintToUserCodes < ActiveRecord::Migration

  def up
    add_index :users, :user_code, :unique => true
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end

end
