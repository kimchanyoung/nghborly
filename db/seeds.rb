# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create a single group

Group.find_or_create_by({primary_number: "48",
                         street_name: "Wall",
                         street_suffix: "St",
                         city_name: "New York",
                         state_abbreviation: "NY",
                         zipcode: "10005"})
