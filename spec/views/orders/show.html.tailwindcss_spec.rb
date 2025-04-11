require 'rails_helper'

RSpec.describe "orders/show", type: :view do
  before(:each) do
    assign(:order, Order.create!(
      user: nil,
      status: "Status",
      total: "9.99",
      address: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(//)
  end
end
