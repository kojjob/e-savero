require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password_digest).is_at_least(6) }
    it { should validate_presence_of(:session_token) }
    it { should validate_uniqueness_of(:session_token) }
  end

  describe "associations" do
    it { should have_many(:orders) }
    it { should have_many(:cart_items) }
    it { should have_many(:reviews) }
    it { should have_many(:addresses) }
    it { should have_many(:payments) }
  end
end
