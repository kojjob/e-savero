class Address < ApplicationRecord
  belongs_to :user
  has_many :orders

  validates :street, :city, :state, :postal_code, :country, :address_type, presence: true
  validates :address_type, inclusion: { in: ['billing', 'shipping'] }
end
