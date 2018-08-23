Category.delete_all
Product.delete_all

category = Category.create!(name: Faker::GameOfThrones.house)
9.times do
  category.products << Product.create(
    name: Faker::Food.dish,
    description: Faker::Food.description,
    price: Faker::Number.decimal(3, 2),
    img_url: Faker::Avatar.image
  )
end
