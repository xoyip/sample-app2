class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :cart_products
  has_many :products, through: :cart_products

  def product_price
    total = 0
    cart_products.find_each do |cart_product|
      unit_price = cart_product.product.price
      total += unit_price * cart_product.amount
    end
    total
  end

  def shipping_cost
    product_count = cart_products.map {|cart_product| cart_product.amount}.inject(&:+)
    600 * ((product_count - 1) / 5 + 1)
  end

  def cash_on_delivery
    case product_price
    when 0...10000 then 300 
    when 10000...30000 then 400
    when 30000...100000 then 600
    else 1000
    end
  end

  def tax_percentage
    8
  end

  def total_price_with_tax
    (product_price + shipping_cost + cash_on_delivery) * (100 + tax_percentage) / 100
  end
end
