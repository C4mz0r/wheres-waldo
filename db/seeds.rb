# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@trainStation = Picture.create(title: "Train Station", imageFile: "train-station.jpg")
@trainStation.characters.create(name: "Waldo", xPosition: 939, yPosition: 291, isFound: false)
@trainStation.characters.create(name: "Wenda", xPosition: 389, yPosition: 582, isFound: false)
@trainStation.characters.create(name: "Odlaw", xPosition: 260, yPosition: 587, isFound: false)
@trainStation.characters.create(name: "Wizard", xPosition: 452, yPosition: 310, isFound: false)


