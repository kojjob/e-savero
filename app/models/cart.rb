class Cart < ApplicationRecord
  belongs_to :user

  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy

  def add_product(product, quantity = 1)
    current_item = cart_items.find_by(product: product)
    
    if current_item
      current_item.quantity += quantity
      current_item.save
    else
      cart_items.create(product: product, quantity: quantity)
    end
  end

  def total_price
    cart_items.sum { |item| item.product.price * item.quantity }
  end
end
