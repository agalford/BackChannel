namespace :bootstrap do
      desc "Add the default user"
      task :default_user => :environment do
        User.create( :user_code => 'admin',
                     :email => 'admin@admin.com',
                     :encrypted_password => '$2a$10$nH86Bmq.tVmHEUB2P230AePDv2fw602.QOH0TK.pHEl1jSgyUDE9G',
                     :first_name => 'Initial',
                     :last_name => 'Admin',
                     :is_admin => true )
      end

      desc "Run all bootstrapping tasks"
      task :all => [:default_user]
end