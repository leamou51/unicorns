# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require "open-uri"

User.destroy_all
Unicorn.destroy_all
Booking.destroy_all


MAGIC_POWERS = ["ailé", "guérisseuse", "horticultrice", "yogi", "voyante"]

UNICORN_PICTURES = [
  {url: "https://res.cloudinary.com/dfrtup7hb/image/upload/v1597674680/licorne18_cocwmu.jpg", name: "licorne18_cocwmu.jpg"},
  {url: "https://res.cloudinary.com/dfrtup7hb/image/upload/v1597674681/licorne12_hqqyw3.jpg" ,name: "licorne12_hqqyw3.jpg"},
  {url: "https://res.cloudinary.com/dfrtup7hb/image/upload/v1597674680/licorne13_h8av8h.jpg",name: "licorne13_h8av8h.jpg"},
  {url: "https://res.cloudinary.com/dfrtup7hb/image/upload/v1597674680/licorne8_vp7cmz.png",name: "licorne8_vp7cmz.png"},
  {url: "https://res.cloudinary.com/dfrtup7hb/image/upload/v1597674680/licorne16_oozqqe.jpg",name: "licorne16_oozqqe.jpg"},
  {url: "https://res.cloudinary.com/dfrtup7hb/image/upload/v1597674680/licorne14_oivcc7.jpg",name: "licorne14_oivcc7.jpg"},
  {url: "https://res.cloudinary.com/dfrtup7hb/image/upload/v1597674680/licorne10_biltno.jpg",name: "licorne10_biltno.jpg"},
  {url: "https://res.cloudinary.com/dfrtup7hb/image/upload/v1597674680/licorne17_zuz82y.jpg",name: "licorne17_zuz82y.jpg"},
  {url: "https://res.cloudinary.com/dfrtup7hb/image/upload/v1597674680/licorne7_makql8.jpg",name: "licorne7_makql8.jpg"},
  {url: "https://res.cloudinary.com/dfrtup7hb/image/upload/v1597674680/licorne11_mastst.jpg",name: "licorne11_mastst.jpg"},
  {url: "https://res.cloudinary.com/dfrtup7hb/image/upload/v1597674680/licorne6_we54js.jpg",name: "licorne6_we54js.jpg"},
  {url: "https://res.cloudinary.com/dfrtup7hb/image/upload/v1597674680/licorne6_we54js.jpg",name: "licorne6_we54js.jpg"},
  {url: "https://res.cloudinary.com/dfrtup7hb/image/upload/v1597674680/licorne6_we54js.jpg",name: "licorne6_we54js.jpg"},
  {url: "https://res.cloudinary.com/dfrtup7hb/image/upload/v1597674679/licorne2_vwc2ut.jpg",name: "licorne2_vwc2ut.jpg"},
  {url: "https://res.cloudinary.com/dfrtup7hb/image/upload/v1597674679/licorne1_o0vj9c.jpg" ,name: "licorne1_o0vj9c.jpg"},
  {url: "https://res.cloudinary.com/dfrtup7hb/image/upload/v1597674679/licorne5_izdkpv.jpg",name: "licorne5_izdkpv.jpg"},
  {url: "https://res.cloudinary.com/dfrtup7hb/image/upload/v1597674679/licorne4_gronnt.jpg",name: "licorne4_gronnt.jpg"},
  {url: "https://res.cloudinary.com/dfrtup7hb/image/upload/v1597674679/licorne3_xs9plo.jpg",name: "licorne3_xs9plo.jpg"},
  {url: "https://res.cloudinary.com/dfrtup7hb/image/upload/v1597674679/15_iayhct.jpg",name: "15_iayhct.jpg"}
]

CITIES = [
  "56 Avenue Jules Ferry, 02200 Soissons Picardie",
  "83 Avenue Millies Lacroix 59640 Dunkerque",
  "65  Square de la Couronne PALAISEAU Île-de-France",
  "99, rue des Dunes 35400 SAINT-MALO",
  "74  place Maurice-Charretier CHARENTON-LE-PONT Île-de-France",
  "106  rue Beauvau MARSEILLE Provence-Alpes-Côte d'azur",
  "10  place Maurice-Charretier CHARLEVILLE-MÉZIÈRES Champagne-Ardenne",
  "15 rue la Boétie Paris Île-de-France",
  "24  avenue du Marechal Juin SAINT-LÔ Basse-normandie",
  "67  rue Charles Corbeau ÉVREUX Haute-Normandie",
  "90  rue Goya LE PERREUX-SUR-MARNE Île-de-France",
  "86  avenue de Provence VANNES Bretagne",
  "128  avenue Voltaire MAISONS-ALFORT Île-de-France",
  "89 Avenue de provence VALLAURIS Provence-Alpes-Côte d'azur",
  "119  Rue Hubert de Lisle LUNEL Languedoc-Roussillon",
  "132  Rue de Strasbourg CLICHY Île-de-France",
  "75  rue du Général Ailleret LES LILAS Île-de-France",
  "88  place de Miremont VILLENEUVE-SUR-LOT Aquitaine",
  "65  boulevard Bryas CREIL Picardie",
  "73  Boulevard de Normandie FORT-DE-FRANCE Martinique"
]

10.times do
  user_name = Faker::Name.first_name
  user = User.new(
    pseudo: "#{user_name}#{rand(1..99)}",
    email: Faker::Internet.email(name: user_name),
    password: Faker::Internet.password(min_length: 8, max_length: 12),
    rating: rand(2.0..4.99).round(2)
  )
  user.save
end


count = 0
17.times do
  unicorn_names = [Faker::Artist.name, Faker::TvShows::Friends.character, Faker::Movies::LordOfTheRings.character, Faker::DcComics.hero, Faker::DcComics.heroine, Faker::TvShows::GameOfThrones.character]
  unicorn = Unicorn.new(
    name: unicorn_names.sample,
    magic_power: MAGIC_POWERS.sample,
    description: Faker::Lorem.paragraph(sentence_count: rand(2..6)),
    location: CITIES[count],
    price: rand(350.0..1050.0).round(2),
    user: User.all.to_a.sample
  )
  unicorn.save
  unicorn.photos.attach(io: URI.open(UNICORN_PICTURES[count][:url]), filename: UNICORN_PICTURES[count][:name])
  unicorn.photos.attach(io: URI.open(UNICORN_PICTURES[count + 1][:url]), filename: UNICORN_PICTURES[count + 1][:name])
  count += 1
end

30.times do
  booking_start_date = Faker::Date.between(from: '2020-08-26', to: '2020-09-10')
  unicorn = Unicorn.all.to_a.sample
  booking = Booking.new(
    start_date: booking_start_date,
    end_date: Faker::Date.between(from: booking_start_date, to: '2020-09-15'),
    rating: rand(1..5),
    review: Faker::Lorem.paragraph(sentence_count: rand(1..5)),
    unicorn: unicorn,
    user: User.all.to_a.select { |user| user != unicorn.user  }.sample
  )
  booking.save
end



