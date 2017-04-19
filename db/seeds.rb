# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Users
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             confirmed_at: Time.zone.now)

5.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               confirmed_at: Time.zone.now)
end

# Products
50.times do
  name   = Faker::Commerce.product_name
  price  = Faker::Commerce.price
  number = Faker::Number.between(1, 30)
  description = Faker::Lorem.paragraph(2, true)
  Product.create!(name:        name,
                  description: description,
                  price:       price)
end

# Categories
10.times do
  name = Faker::Commerce.department(1, true)
  Category.create!(name: name)
end

# Sub-Categories
20.times do
  name   = Faker::Commerce.department(1, true)
  number = Faker::Number.between(1, 10)
  Category.find(number).sub_categories.create!(name: name)
end

# Add product to category
Product.all.each do |product|
  number = Faker::Number.between(1, 30)
  product.product_categories.create!(category_id: number)
end
