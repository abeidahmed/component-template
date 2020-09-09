# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = [
  'Cta sections',
  'Navbars',
  'Page headings',
  'Buttons',
  'Feature sections',
  'Avatars',
  'Hero sections',
  'Sidebar layouts',
  'Sign-in and registrations'
]

if Rails.env.production?
  categories.each do |category|
    Category.create!(title: category) unless Category.exists?(title: category)
  end
else
  puts "Cannot run seed on development and test environment!"
end
