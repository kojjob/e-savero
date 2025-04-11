require 'rails_helper'

RSpec.describe "addresses/index", type: :view do
  before(:each) do
    assign(:addresses, [
      Address.create!(
        street: "Street",
        city: "City",
        state: "State",
        postal_code: "Postal Code",
        country: "Country",
        user: nil,
        address_type: "Address Type"
      ),
      Address.create!(
        street: "Street",
        city: "City",
        state: "State",
        postal_code: "Postal Code",
        country: "Country",
        user: nil,
        address_type: "Address Type"
      )
    ])
  end

  it "renders a list of addresses" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Street".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("City".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("State".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Postal Code".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Country".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Address Type".to_s), count: 2
  end
end
