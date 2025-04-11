require 'rails_helper'

RSpec.describe "order_items/new", type: :view do
  before(:each) do
    assign(:order_item, OrderItem.new(
      order: nil,
      product: nil,
      quantity: 1,
      unit_price: "9.99"
    ))
  end

  it "renders new order_item form" do
    render

    assert_select "form[action=?][method=?]", order_items_path, "post" do

      assert_select "input[name=?]", "order_item[order_id]"

      assert_select "input[name=?]", "order_item[product_id]"

      assert_select "input[name=?]", "order_item[quantity]"

      assert_select "input[name=?]", "order_item[unit_price]"
    end
  end
end
