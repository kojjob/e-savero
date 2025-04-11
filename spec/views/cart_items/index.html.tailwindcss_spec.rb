require 'rails_helper'

RSpec.describe "cart_items/index", type: :view do
  before(:each) do
    assign(:cart_items, [
      CartItem.create!(
        cart: nil,
        product: nil,
        quantity: 2
      ),
      CartItem.create!(
        cart: nil,
        product: nil,
        quantity: 2
      )
    ])
  end

  it "renders a list of cart_items" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
  end
end
