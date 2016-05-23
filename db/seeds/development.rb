# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# ----------------------------------------
# Clean Database
# ----------------------------------------
if Rails.env == 'development'
  puts 'Cleaning database'
  Follow.destroy_all
  Photo.destroy_all
  Profile.destroy_all
  SnapItLanguage.destroy_all
  SnapItTheme.destroy_all
  SnapIt.destroy_all
  SnapItProxy.destroy_all
  User.destroy_all
end


# ----------------------------------------
# Config
# ----------------------------------------

TAGS = [
  'dude',
  'awesome',
  'totesmygoats',
  '1234five',
  'one2345',
  'with_underscore',
  'areallylongtagtoseewhatitisliketohavereallylongtags',
  'AtagWithMixedCase1234'
]

def random_snap_it_image
  path = Rails.root.join('data', 'images', '*.jpg')
  file = Dir.glob(path).sample
  filename = file.split('/').last
  {
    :filename => filename,
    :language => filename.split('.').first,
    :path => file
  }
end


def random_date(start=nil, finish=nil)
  start ||= 5.years.ago
  finish ||= Time.now
  rand(start..finish)
end


def random_tag
  "##{TAGS.sample}"
end


# ----------------------------------------
# Start Seeds
# ----------------------------------------
puts 'Seeding...'
puts


# ----------------------------------------
# Create SnapItLanguages
# ----------------------------------------
puts 'Creating SnapItLanguages'

Rake::Task['editor:seed:languages'].invoke
puts

# ----------------------------------------
# Create SnapItThemes
# ----------------------------------------
puts 'Creating SnapItThemes'

Rake::Task['editor:seed:themes'].execute
puts


# ----------------------------------------
# Create Users
# ----------------------------------------
puts 'Creating Users'

30.times do |i|
  date = random_date
  u = User.new(
    username: "Foobar#{i}",
    email: "test#{i}@example.com",
    password: "password",
    created_at: date,
    updated_at: date)
  u.skip_confirmation!
  u.save!
end

p = User.find_by_email("test1@example.com").profile
p.full_name = "Dr Foo Bar"
p.website = "http://www.example.com"
p.bio = "Lorem ipsum dolor sit amet, consectetur adipisicing elit."
p.save!

users = User.all


# ----------------------------------------
# Create SnapItProxies
# ----------------------------------------
puts 'Creating SnapItProxies'

snap_it_proxies = []
1.times do
  snap_it_proxies << {
    :title => 'Hello',
    :description => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. At doloremque eius distinctio sequi repellendus fugiat accusamus sit in et quas, consequatur recusandae temporibus tempore qui labore, voluptates ex. Doloribus, blanditiis.',
    :body => 'var = "Hello World!"',
    :snap_it_language_id => SnapItLanguage.find_by_editor_name('javascript').id,
    :snap_it_theme_id => SnapItTheme.find_by_editor_name('monokai').id,
    :user_id => User.first.id
  }
end
SnapItProxy.create(snap_it_proxies)
snap_it_proxies = SnapItProxy.all


# ----------------------------------------
# Create SnapIts
# ----------------------------------------
puts 'Creating SnapIts'

snap_its = []
users.each do |user|
  rand(5).times do |i|
    snap_it = user.snap_its.build(
      :created_at => random_date(user.created_at),
      :updated_at => random_date(user.updated_at)
    )
    snap_it.title = "My SnapIt by #{user.username}"
    snap_it.description = "My SnapIt has an epic description, #{random_tag}"
    snap_it.body = 'Lorem ipsum dolor sit amet.'

    image = random_snap_it_image
    snap_it.snap_it_language = SnapItLanguage.find_by_editor_name(image[:language])
    snap_it.snap_it_theme = SnapItTheme.first
    snap_it.build_photo(:file => File.new(image[:path]))

    snap_it.save!
  end
end
snap_its = SnapIt.all


# ----------------------------------------
# Adjust Activity Feed Dates
# ----------------------------------------
puts 'Adjusting Activity Feed Dates'

Activity.all.each do |activity|
  activity.update!(
    :created_at => activity.activity_feedable.created_at,
    :updated_at => activity.activity_feedable.updated_at
  )
end


# ----------------------------------------
# Create Tags
# ----------------------------------------
puts 'Creating Tags'

tags = []
SnapItLanguage.all.each do |snap_it_language|
  Tag.find_or_create_by!(
    :name => snap_it_language.editor_name
  )
end
SnapItTheme.all.each do |snap_it_theme|
  Tag.find_or_create_by!(
    :name => snap_it_theme.editor_name
  )
end
tags = Tag.all


# ----------------------------------------
# Finish Seeds
# ----------------------------------------
puts
puts 'Done'












