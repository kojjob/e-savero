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

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true, length: { minimum: 6 }
  validates :session_token, presence: true, uniqueness: true

  attr_reader :password

  after_initialize :ensure_session_token

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil unless user && user.is_password?(password)
    user
  end

  private
  def create_cart
    Cart.create(user_id: self.id) unless self.cart
  end
end
