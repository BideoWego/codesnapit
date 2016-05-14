# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# ----------------------------------------
# Config
# ----------------------------------------

# Space for seed config


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


# ----------------------------------------
# Create SnapItThemes
# ----------------------------------------
puts 'Creating SnapItThemes'

Rake::Task['editor:seed:themes'].execute


# ----------------------------------------
# Finish Seeds
# ----------------------------------------
puts
puts 'Done'












