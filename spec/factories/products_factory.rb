FactoryBot.define do
  factory :product do
    name "Product Name"
    description "this is description"
    price 982.99
    img_url "https://via.placeholder.com/150x150"
    category { create(:category) }
  end
end
