FactoryBot.define do
  factory :product do
    name { "MyString" }
    description { "MyText" }
    price { "9.99" }
    stock_quantity { 1 }
    category { nil }
  end
end
