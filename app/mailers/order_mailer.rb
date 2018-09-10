class OrderMailer < ApplicationMailer
  default from: 'suppurt.urban96@gmail.com'

  def finished_order_email(order)
    @order = order

    mail(to:@order.email, subject: 'Finished Order at ACV-Ecommerce')
  end
end
