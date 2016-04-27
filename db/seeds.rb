# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'Seeding...'

if Rails.env == 'development'
  Rake::Task['db:migrate:reset'].invoke
end

3.times do |i|
  User.create!(
    username: "Foobar",
    email: "test#{i}@example.com",
    password: "password")
end

p = User.find_by_email("test1@example.com").profile
p.full_name = "Dr Foo Bar"
p.website = "http://www.example.com"
p.bio = "Lorem ipsum dolor sit amet, consectetur adipisicing elit."
p.save!

puts 'Done'

