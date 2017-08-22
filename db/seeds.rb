# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Flat.destroy_all
Flat.create(name: "Charming Mansion in Montmartre", address: "12, impasse Marie-Blanche, Paris")
Flat.create(name: "Lovely studio Raspail", address: "9, rue d'Odessa, Paris")
Flat.create(name: "Nice Flat. Bonne Nouvelle", address: "18, rue d'Hauteville, Paris")
Flat.create(name: "Awesome House near Buttes-Chaumont", address: "18, rue de l'Atlas, Paris")

