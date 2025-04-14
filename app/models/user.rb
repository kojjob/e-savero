class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :lockable, :timeoutable, :trackable, :omniauthable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :cart_items, dependent: :destroy
  has_many :reviews
  has_many :addresses
  has_one :cart, dependent: :destroy
  has_one_attached :avatar

  after_create :create_cart

  # User avatar methods
  def avatar_url
    if avatar.attached?
      # Change this URL to match your application's URL for avatar display
      # For example, using Rails routes to ActiveStorage attachments
      Rails.application.routes.url_helpers.rails_blob_url(avatar, only_path: true)
    else
      nil
    end
  end

  def has_avatar?
    avatar.attached?
  end

  private
  def create_cart
    Cart.create(user_id: self.id) unless self.cart
  end
end
