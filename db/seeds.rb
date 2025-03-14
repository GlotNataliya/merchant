# frozen_string_literal: true

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

# category1 = Category.create!( name: "New arrival")
# category2 = Category.create!( name: "Water, juices, drinks")
# category3 = Category.create!( name: "Nuts")

# fruit1 = Product.create!(
#   title: "Avocado",
#   price: Faker::Commerce.price,
#   description: "1 pc",
#   image: "avocado.jpg",
#   stock: Faker::Number.between(from: 1, to: 100),
#   category_id: category1.id
# )

# fruit2 = Product.create!(
#   title: "Pineapple",
#   price: Faker::Commerce.price,
#   description: "1 pc",
#   image: "pineapple.jpg",
#   stock: Faker::Number.between(from: 1, to: 100),
#   category_id: category1.id
# )

# fruit3 = Product.create!(
#   title: "Pear Duchess",
#   price: Faker::Commerce.price,
#   description: "1 kg",
#   image: "pear.jpg",
#   stock: Faker::Number.between(from: 1, to: 100),
#   category_id: category1.id
# )

# fruit4 = Product.create!(
#   title: "Pomegranate",
#   price: Faker::Commerce.price,
#   description: "1 kg",
#   image: "pomegranate.jpg",
#   stock: Faker::Number.between(from: 1, to: 100),
#   category_id: category1.id
# )

# fruit5 = Product.create!(
#   title: "Grapefruit",
#   price: Faker::Commerce.price,
#   description: "1 kg",
#   image: "grapefruit.jpg",
#   stock: Faker::Number.between(from: 1, to: 100),
#   category_id: category1.id
# )

# fruit6 = Product.create!(
#   title: "Peach",
#   price: Faker::Commerce.price,
#   description: "1 kg",
#   image: "peach.jpg",
#   stock: Faker::Number.between(from: 1, to: 100),
#   category_id: category1.id
# )

# juice1 = Product.create!(
#   title: "Banana juice",
#   price: Faker::Commerce.price,
#   description: "1 liter",
#   image: "Banana_juice.jpg",
#   stock: Faker::Number.between(from: 1, to: 100),
#   category_id: category2.id
# )

# juice2 = Product.create!(
#   title: "Grapefruit juice",
#   price: Faker::Commerce.price,
#   description: "1 liter",
#   image: "Grapefruit_juice.jpg",
#   stock: Faker::Number.between(from: 1, to: 100),
#   category_id: category2.id
# )

# juice3 = Product.create!(
#   title: "Apple juice",
#   price: Faker::Commerce.price,
#   description: "1 liter",
#   image: "Apple_juice.jpg",
#   stock: Faker::Number.between(from: 1, to: 100),
#   category_id: category2.id
# )

# juice4 = Product.create!(
#   title: "Orange juice",
#   price: Faker::Commerce.price,
#   description: "1 liter",
#   image: "Orange_juice.jpg",
#   stock: Faker::Number.between(from: 1, to: 100),
#   category_id: category2.id
# )

# juice5 = Product.create!(
#   title: "Pineapple juice",
#   price: Faker::Commerce.price,
#   description: "1 liter",
#   image: "Pineapple_juice.jpg",
#   stock: Faker::Number.between(from: 1, to: 100),
#   category_id: category2.id
# )

# juice6 = Product.create!(
#   title: "Pomegranate juice",
#   price: Faker::Commerce.price,
#   description: "1 liter",
#   image: "Pomegranate_juice.jpg",
#   stock: Faker::Number.between(from: 1, to: 100),
#   category_id: category2.id
# )

# nut1 = Product.create!(
#   title: "Almond",
#   price: Faker::Commerce.price,
#   description: "1 kg",
#   image: "almond.jpg",
#   stock: Faker::Number.between(from: 1, to: 100),
#   category_id: category3.id
# )

# nut2 = Product.create!(
#   title: "Cashew",
#   price: Faker::Commerce.price,
#   description: "1 kg",
#   image: "cashew.jpg",
#   stock: Faker::Number.between(from: 1, to: 100),
#   category_id: category3.id
# )

# nut3 = Product.create!(
#   title: "Hazelnut in shell",
#   price: Faker::Commerce.price,
#   description: "1 kg",
#   image: "hazelnut_in_shell.jpg",
#   stock: Faker::Number.between(from: 1, to: 100),
#   category_id: category3.id
# )

# nut4 = Product.create!(
#   title: "Pistachios in shell",
#   price: Faker::Commerce.price,
#   description: "1 kg",
#   image: "pistachios_in_shell.jpg",
#   stock: Faker::Number.between(from: 1, to: 100),
#   category_id: category3.id
# )

# nut5 = Product.create!(
#   title: "Hazelnuts peeled",
#   price: Faker::Commerce.price,
#   description: "1 kg",
#   image: "hazelnuts_peeled.jpg",
#   stock: Faker::Number.between(from: 1, to: 100),
#   category_id: category3.id
# )

# nut6 = Product.create!(
#   title: "Walnut",
#   price: Faker::Commerce.price,
#   description: "1 kg",
#   image: "walnut.jpg",
#   stock: Faker::Number.between(from: 1, to: 100),
#   category_id: category3.id
# )
