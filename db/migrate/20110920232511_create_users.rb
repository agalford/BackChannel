class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :first_name
      t.string :last_name

      # devise requires its own :email and :password fields
      # t.string :email_address
      # t.string :password_hash

      t.timestamps
    end
  end
end
