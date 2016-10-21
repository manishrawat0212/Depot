namespace :order_notifier do
  desc "Informs all the users about their respective orders via email."
  task :send_email => :environment do |t, args|
    begin
      puts 'Please wait. It will take some time!!!'
      User.all.each do |user|
        user.orders.each do |order|
          OrderNotifier.received(order).deliver
        end
      end
      puts 'Job Done'
    rescue
      puts 'Something went wrong!!!'
    end
  end
end

# Call:
# rake "order_notifier:send_email"
