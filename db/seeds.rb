# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Order.create!  account: 'GAS68058614',
               direction: 'buy',
               order_type: 'limit',
               price: 25_000,
               quantity: 100,
               symbol: 'CDSC',
               venue: 'YEHKEX'
