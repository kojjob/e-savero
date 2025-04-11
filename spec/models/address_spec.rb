require "rails_helper"

RSpec.describe Address, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:orders) }  
    it { should have_many(:payments) }
    it { should have_many(:carts) }
    it { should have_many(:reviews) }
    it { should have_many(:products) }
    it { should have_many(:cart_items) }
  end

  describe "validations" do
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:postal_code) }
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:user) }
  end
end
