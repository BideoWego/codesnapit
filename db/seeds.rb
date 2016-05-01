# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all

3.times do |i|
  u = User.new(
    username: "Foobar",
    email: "test#{i}@example.com",
    password: "password")
  u.skip_confirmation!
  u.save!
end

p = User.find_by_email("test1@example.com").profile
p.full_name = "Dr Foo Bar"
p.website = "http://www.example.com"
p.bio = "Lorem ipsum dolor sit amet, consectetur adipisicing elit."
p.save!