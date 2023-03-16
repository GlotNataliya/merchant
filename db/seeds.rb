# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Product.destroy_all
User.destroy_all
Category.destroy_all

User.create!(
  email: "admin@example.com",
  role: "admin",
  full_name: "Admin",
  avatar_url: Faker::Avatar.image(slug: "my-own-slug", size: "50x50", format: "jpg"),
  password: "@Admin1234",
  password_confirmation: "@Admin1234"
)

2.times do |_user|
  User.create!(email: Faker::Internet.email,
               role: "consumer",
               full_name: Faker::Name.name,
               avatar_url: Faker::Avatar.image(slug: "my-own-slug", size: "50x50", format: "jpg"),
               password: "@User1234",
               password_confirmation: "@User1234")
end

category = Category.create!( name: "Drink")

product1 = Product.create!(
  title: "Avocado",
  price: Faker::Commerce.price,
  description: "1 pc",
  image_url: "large_Авокадо.jpg",
  stock: Faker::Number.between(from: 1, to: 100),
  category_id: category.id
)

product2 = Product.create!(
  title: "Pineapple",
  price: Faker::Commerce.price,
  description: "1 pc",
  image_url: "large_Ананас.jpg",
  stock: Faker::Number.between(from: 1, to: 100),
  category_id: category.id
)

product3 = Product.create!(
  title: "Pear Duchess",
  price: Faker::Commerce.price,
  description: "1 kg",
  image_url: "large_Груша_дюшес.jpg",
  stock: Faker::Number.between(from: 1, to: 100),
  category_id: category.id
)

product4 = Product.create!(
  title: "Pomegranate",
  price: Faker::Commerce.price,
  description: "1 kg",
  image_url: "large_Гранат.jpg",
  stock: Faker::Number.between(from: 1, to: 100),
  category_id: category.id
)

product5 = Product.create!(
  title: "Grapefruit",
  price: Faker::Commerce.price,
  description: "1 kg",
  image_url: "large_Грейпфрут.jpg",
  stock: Faker::Number.between(from: 1, to: 100),
  category_id: category.id
)

product6 = Product.create!(
  title: "Peach",
  price: Faker::Commerce.price,
  description: "1 kg",
  image_url: "large_Персик.jpg",
  stock: Faker::Number.between(from: 1, to: 100),
  category_id: category.id
)
