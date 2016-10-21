class OrderNotifier < ActionMailer::Base
  default from: 'Manish Rawat <manishrawat0212@gmail.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.received.subject
  #
  def received(order)
    @order = order;
    @order.line_items.each do |line_item|
      line_item.product.images.each_with_index do |image, index|
        if index == 0
          attachments.inline[image.url] = File.read(Rails.root.join('app', 'assets', 'images', image.url))
        else
          attachments[image.url] = File.read(Rails.root.join('app', 'assets', 'images', image.url))
        end
      end
    end

    language = @order.user.language
    if language == 'hindi'
      locale = :hi
    else
      locale = :en
    end

    headers['X-SYSTEM-PROCESS-ID'] = "#{Process.pid}"

    I18n.with_locale(locale) do
      mail to: @order.email, subject: t('.subject')
    end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.shipped.subject
  #
  def shipped(order)
    @order = order;

    mail to: order.email, subject: 'Pragmatic Store Order Shipped'
  end
end
