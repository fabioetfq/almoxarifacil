# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Cleaning database..."

Material.destroy_all
Transaction.destroy_all

puts "Creating materials..."
gloves = {name: "Luva Nitrílica M", category: "Luva", qty: 16}
alcohol = {name: "Etanol 70%", category: "Etanol", qty: 250}
[gloves, alcohol].each do |attributes|
  material = Material.create!(attributes)
  puts "Created #{Material.name}"
end
puts "Finished!"