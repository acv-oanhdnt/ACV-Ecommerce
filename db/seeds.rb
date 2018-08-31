Category.delete_all
Product.delete_all

ActiveRecord::Base.connection.execute("ALTER SEQUENCE products_id_seq RESTART WITH 1")
ActiveRecord::Base.connection.execute("ALTER SEQUENCE categories_id_seq RESTART WITH 1")

5.times do
  category = Category.create!(name: Faker::GameOfThrones.house)
  12.times do
    category.products << Product.create(
      name: Faker::Food.dish,
      description: Faker::Food.description,
      price: Faker::Number.decimal(3, 2),
      img_url: Faker::Avatar.image
    )
  end
end
