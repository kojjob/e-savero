require 'rails_helper'

RSpec.describe Order, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:address) }
    it { should have_many(:order_items).dependent(:destroy) }
    it { should have_many(:products).through(:order_items) }
    it { should have_many(:payments).dependent(:destroy) }
    it { should have_many(:reviews).dependent(:destroy) }
    it { should have_many(:cart_items).dependent(:destroy) }
    it { should have_many(:carts).through(:cart_items) }
    it { should have_many(:categories).through(:products) }
  end

  describe "validations" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:status) }
    it { should validate_inclusion_of(:status).in_array(%w[pending processing completed cancelled]) }
    it { should validate_presence_of(:total) }
    it { should validate_presence_of(:address) }
  end
end
