FactoryBot.define do
  factory :order do
    user { nil }
    status { "MyString" }
    total { "9.99" }
    address { nil }
  end
end
