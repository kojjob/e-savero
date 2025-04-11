require "rails_helper"

RSpec.describe Cart, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe "associations" do
    it { should have_many(:addresses) }
    it { should have_many(:cart_items) }
    it { should have_many(:orders) }
    it { should have_many(:products) }
    it { should belong_to(:user) }
  end
end
