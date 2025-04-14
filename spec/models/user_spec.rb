require 'rails_helper'

RSpec.describe User, type: :model do
  # Devise handles validations for email and password
  # No need to test those explicitly

  describe "associations" do
    it { should have_many(:orders) }
    it { should have_many(:cart_items) }
    it { should have_many(:reviews) }
    it { should have_many(:addresses) }
    it { should have_one(:cart) }
  end

  describe "callbacks" do
    it "creates a cart after user creation" do
      user = User.create(email: "test@example.com", password: "password", password_confirmation: "password")
      expect(user.cart).to be_present
    end
  end
end
