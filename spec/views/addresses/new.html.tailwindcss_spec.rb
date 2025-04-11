require 'rails_helper'

RSpec.describe "addresses/new", type: :view do
  before(:each) do
    assign(:address, Address.new(
      street: "MyString",
      city: "MyString",
      state: "MyString",
      postal_code: "MyString",
      country: "MyString",
      user: nil,
      address_type: "MyString"
    ))
  end

  it "renders new address form" do
    render

    assert_select "form[action=?][method=?]", addresses_path, "post" do

      assert_select "input[name=?]", "address[street]"

      assert_select "input[name=?]", "address[city]"

      assert_select "input[name=?]", "address[state]"

      assert_select "input[name=?]", "address[postal_code]"

      assert_select "input[name=?]", "address[country]"

      assert_select "input[name=?]", "address[user_id]"

      assert_select "input[name=?]", "address[address_type]"
    end
  end
end
