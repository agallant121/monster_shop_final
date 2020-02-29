# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Merchant.destroy_all
Item.destroy_all

#Admin user to login with
admin = User.create!(name: "Bill Gates", street_address: "953 Wealth Blvd",
  city: "Seattle", state: "WA", zip: "54874", email: "admin@gmail.com", password: "admin", role: 3)

bill_nye = User.create!(name: "Bill Nye", street_address: "6578 Pennsylvania St NW",
                          city: "Los Angeles", state: "CA", zip: "90036", email: "regular@gmail.com", password: "regular", role: 1)



bike_shop = Merchant.create!(name: 'Flat Tire', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
#bike_shop employee
lance = bike_shop.users.create!(name: "Lance Armstrong", street_address: "571 Cheater St",
  city: "Colorado Springs", state: "CO", zip: "80206", email: "lance@gmail.com", password: "lance", role: 2)
#bike_shop items
ogre = bike_shop.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 20 )
giant = bike_shop.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 20 )
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 20)
maxxis_DH = bike_shop.items.create(name: "Maxxis DHR", description: "Awesome grp!", price: 150, image: "https://i.ebayimg.com/images/i/142126821783-0-1/s-l1000.jpg", inventory: 20)
death_grips = bike_shop.items.create(name: "death grips ", description: "Awesome grips!", price: 40, image: "https://brink.uk/assets/images/generic/DMR-Brendog-Death-Grips.jpg", inventory: 20)
downhill_rims = bike_shop.items.create(name: "STANS flow s1  29er", description: "Awesome rim!", price: 250, image: "https://www.wigglestatic.com/product-media/163035/Stans-No-Tubes-Flow-S1-MTB-Wheelset-Internal-Black-Grey-NotSet-850-WS1FL7004-6.jpg?w=2000&h=2000&a=7", inventory: 12)
xx1 = bike_shop.items.create(name: "XX1 eagle cassette", description: "Best around", price: 700, image: "https://content.competitivecyclist.com/images/items/1200/SRM/SRM009X/GD.jpg", inventory: 20)
cranks = bike_shop.items.create(name: "carbon cranks ", description: "LIGHT", price: 300, image: "https://www.sefiles.net/images/library/zoom/sram-x7-crankset-44-32-22-9-speed-copy-184997-1.jpg", inventory: 20)


dog_shop = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
#dog_shop employee
abby = dog_shop.users.create!(name: "Abby Gallant", street_address: "678 Dog Lover St",
  city: "Yarmouth", state: "ME", zip: "04240", email: "abby@gmail.com", password: "abby", role: 2)
#dog_shop items
hippo = dog_shop.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 20)
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 20)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 20)
dog_bath = dog_shop.items.create(name: "Bath", description: "They'll be clean!", price: 50, image: "https://naturaldogcompany.com/wp-content/uploads/2018/03/dog-bubble-bath-web.jpg", active?:false, inventory: 20)
chuck_it = dog_shop.items.create(name: "Chuck It", description: "They'll fetch it!", price: 10, image: "https://www.halfmoonoutfitters.com/assets/images/jumbos/lib_chuckit_lg.jpg", active?:false, inventory: 20)
frisbee = dog_shop.items.create(name: "Frisbee", description: "They fly far!", price: 5, image: "https://www.gophersport.com/cmsstatic/img/918/G-10395-FrisbeeFreestyle-features-01-clean.jpg", active?:false, inventory: 20)
