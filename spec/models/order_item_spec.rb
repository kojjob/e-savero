require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe "associations" do
    it { should belong_to(:order) }
    it { should belong_to(:product) }
  end

  describe "validations" do
    it { should validate_presence_of(:order) }
    it { should validate_presence_of(:quantity).numericality.is_only_integer.is_greater_than(0) }
    it { should validate_presence_of(:unit_price). }
  end
end
