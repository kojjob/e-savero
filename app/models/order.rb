class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  has_many :payments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
  has_many :categories, through: :products

  validates :user, presence: true
  validates :status, presence: true, inclusion: { in: ['pending', 'processing', 'completed', 'cancelled'] }

  def total_price
    order_items.sum { |item| item.unit_price * item.quantity }
  end

  def create_from_cart(cart, address)
    transaction do
      cart.cart_items.each do |cart_item|
        order_items.create!(
          product: cart_item.product,
          quantity: cart_item.quantity,
          unit_price: cart_item.product.price
        )
      end
      
      update!(total: total_price)
      cart.cart_items.destroy_all
    end
  end
end