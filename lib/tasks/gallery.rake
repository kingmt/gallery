namespace :gallery do
  # Add a task to create basic admin user
  desc "Add basic admin user"
  task (:add_admin => :environment) do |t|
    u = User.new :email => 'admin@example.com', :password => 'admin', :password_confirmation => 'admin'
    u.add_admin_role
    u.save
  end
end