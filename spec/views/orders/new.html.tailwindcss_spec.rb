require 'rails_helper'

RSpec.describe "orders/new", type: :view do
  before(:each) do
    assign(:order, Order.new(
      user: nil,
      status: "MyString",
      total: "9.99",
      address: nil
    ))
  end

  it "renders new order form" do
    render

    assert_select "form[action=?][method=?]", orders_path, "post" do

      assert_select "input[name=?]", "order[user_id]"

      assert_select "input[name=?]", "order[status]"

      assert_select "input[name=?]", "order[total]"

      assert_select "input[name=?]", "order[address_id]"
    end
  end
end
