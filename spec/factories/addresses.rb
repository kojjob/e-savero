FactoryBot.define do
  factory :address do
    street { "MyString" }
    city { "MyString" }
    state { "MyString" }
    postal_code { "MyString" }
    country { "MyString" }
    user { nil }
    address_type { "MyString" }
  end
end
