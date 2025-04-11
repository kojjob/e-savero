require 'rails_helper'

RSpec.describe "cart_items/edit", type: :view do
  let(:cart_item) {
    CartItem.create!(
      cart: nil,
      product: nil,
      quantity: 1
    )
  }

  before(:each) do
    assign(:cart_item, cart_item)
  end

  it "renders the edit cart_item form" do
    render

    assert_select "form[action=?][method=?]", cart_item_path(cart_item), "post" do

      assert_select "input[name=?]", "cart_item[cart_id]"

      assert_select "input[name=?]", "cart_item[product_id]"

      assert_select "input[name=?]", "cart_item[quantity]"
    end
  end
end
