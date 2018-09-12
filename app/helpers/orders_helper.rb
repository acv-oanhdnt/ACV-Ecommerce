module OrdersHelper
  def create_request_payment(items, return_url, cancel_url)
    order_items = []
    calculate = 0
    items.each do |product, qtt|
      order_items << {
        name: product.name,
        sku: product.id.to_s,
        price: product.price.to_s,
        currency: 'USD',
        quantity: qtt['quantity']
      }
      calculate += product.price * qtt['quantity']
    end

    PayPal::SDK::REST::Payment.new(
      intent: 'sale',
      payer: {
        payment_method: 'paypal'
      },
      redirect_urls: {
        return_url: return_url,
        cancel_url: cancel_url
      },
      transactions: [{
        item_list: {
          items: order_items
        },
        amount: {
          total: calculate.to_s,
          currency: 'USD'
        },
        description: 'This is the payment transaction for your order from jientdongoc.'
      }]
    )
  end

  def convert_cart_items_to_order_items(items)
    h = {}
    items.each do |product, hash|
      h[product.id] = hash
    end
    h
  end
end
