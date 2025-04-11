require 'rails_helper'

RSpec.describe Product, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:price).is_greater_than(0)}
    it { should validate_presence_of(:stock_quantity).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe "associations" do
    it { should belong_to(:category) }
    it { should have_many(:cart_items) }
    it { should have_many(:order_items) }
  end

end
