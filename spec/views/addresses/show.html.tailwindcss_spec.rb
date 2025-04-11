require 'rails_helper'

RSpec.describe "addresses/show", type: :view do
  before(:each) do
    assign(:address, Address.create!(
      street: "Street",
      city: "City",
      state: "State",
      postal_code: "Postal Code",
      country: "Country",
      user: nil,
      address_type: "Address Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Street/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/State/)
    expect(rendered).to match(/Postal Code/)
    expect(rendered).to match(/Country/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Address Type/)
  end
end
