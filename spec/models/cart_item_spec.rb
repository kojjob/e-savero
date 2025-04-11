require 'rails_helper'

RSpec.describe CartItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe "associations" do
    it { should belong_to(:cart) }
    it { should belong_to(:product) }
  end

  describe "validations" do
    it { should validate_presence_of(:cart) }
    it { should validate_presence_of(:product) }
    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:quantity).is_only_integer.is_greater_than(0) }
  end
end
