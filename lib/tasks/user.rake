namespace :user do
  desc "Make a user as admin"
  task :make_admin, [:email]  => :environment do |t, args|
    begin
      user = User.find_by_email(args.email)
      user.role = 'admin'
      user.save!
      puts "Done!!! #{user.name} is now an admin."
    rescue
      puts 'Something went wrong!!!'
    end
  end
end

# Call:
# rake "user:make_admin[manish.rawat@vinsol.com]"
