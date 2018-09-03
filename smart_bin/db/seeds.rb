# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!([
    {username: "admin", email: "admin@smartbin.com", password: "qwerasdf", password_confirmation: "qwerasdf", role: 0},
    {username: "company", email: "company@smartbin.com", password: "qwerasdf", password_confirmation: "qwerasdf", role: 1},
    {username: "user1", email: "user1@smartbin.com", password: "qwerasdf", password_confirmation: "qwerasdf", role: 2},
    {username: "user2", email: "user2@smartbin.com", password: "qwerasdf", password_confirmation: "qwerasdf", role: 2},
    {username: "user3", email: "user3@smartbin.com", password: "qwerasdf", password_confirmation: "qwerasdf", role: 2}
  ])

State.create!([
    {name: "Selangor"},
    {name: "Kuala Lumpur"},
    {name: "Pulau Penang"},
    {name: "Perak"},
    {name: "Kedah"},
    {name: "Negeri Sembilan"},
    {name: "Melaka"},
    {name: "Johor"},
    {name: "Pahang"},
    {name: "Terrengganu"},
    {name: "Perlis"},
    {name: "Kelantan"},
    {name: "Sabah"},
    {name: "Sarawak"},
    {name: "Labuan"}
])

City.create!([
    {name: "Petaling Jaya", state_id: 1},
    {name: "Damansara", state_id: 1},
    {name: "Puchong", state_id: 1},
    {name: "Subang", state_id: 1},
    {name: "Cheras", state_id: 1},
    {name: "Kajang", state_id: 1},
    {name: "Taman Tun Dr. Ismail", state_id: 2},
    {name: "Bukit Jalil", state_id: 2},
    {name: "Pandan Indah", state_id: 2},
    {name: "Georgetown", state_id: 3},
    {name: "Ipoh", state_id: 4},
    {name: "Tapah", state_id: 4},
    {name: "Ipoh", state_id: 4},
    {name: "Sungai Petani", state_id: 5},
    {name: "Alor Setar", state_id: 5}
])

Area.create!([
    {name: "Section 14", city_id: 1, state_id: 1},
    {name: "SS2", city_id: 1, state_id: 1},
    {name: "Taman Tun Dr. Ismail", city_id: 2, state_id: 2},
    {name: "Sungai Long", city_id: 1, state_id: 1},
    {name: "Bandar Mahkota Cheras", city_id: 6, state_id: 1}
])

FillLevel.create!([
    {level: 0, percentage: "0%", description: "Empty"},
    {level: 10, percentage: "10%", description: "Begin"},
    {level: 20, percentage: "20%", description: "Filling"},
    {level: 30, percentage: "30%", description: "Litter"},
    {level: 40, percentage: "40%", description: "Below Half"},
    {level: 50, percentage: "50%", description: "Half"},
    {level: 60, percentage: "60%", description: "Above Half"},
    {level: 70, percentage: "70%", description: "Alert"},
    {level: 80, percentage: "80%", description: "Full"},
    {level: 90, percentage: "90%", description: "Critical"},
    {level: 100, percentage: "100%", description: "Immediate"}
])

Raspberrypi.create!([
    {pi_name: "Raspberry 1", pi_type: "Raspberry Pi", ip_address: "101.169.20.1", mac_address: "AA:CC:DD:EE:AF", longitude: 3.133712, latitude: 101.629692},
    {pi_name: "Raspberry 2", pi_type: "Raspberry Pi", ip_address: "101.169.20.2", mac_address: "AA:CC:DD:EE:AG", longitude: 3.133309, latitude: 101.626877},
    {pi_name: "Raspberry 3", pi_type: "Raspberry Pi", ip_address: "101.169.20.3", mac_address: "AA:CC:DD:EE:BA", longitude: 3.135937, latitude: 101.624967},
    {pi_name: "Raspberry 4", pi_type: "Raspberry Pi", ip_address: "101.169.20.4", mac_address: "AA:CC:DD:EE:DF", longitude: 3.124703, latitude: 101.610388},
    {pi_name: "Raspberry 5", pi_type: "Blueberry Pi", ip_address: "101.169.20.5", mac_address: "AA:CC:DD:EE:EG", longitude: 3.117143, latitude: 101.612760},
    {pi_name: "Raspberry 6", pi_type: "Strawberry Pi", ip_address: "101.169.20.6", mac_address: "AA:CC:DD:EE:CA", longitude: 3.115297, latitude: 101.606691}
])

Dustbin.create!([
    {name: "TTDI Waste Center 1", code: "TTDI0001", address: "Jalan 1/2, Taman Tun Dr. Ismail", longitude: 3.133712, latitude: 101.629692, fill_level_id: 6, state_id: 2, city_id: 7, area_id: 1, raspberrypi_id: 1},
    {name: "TTDI Waste Center 2", code: "TTDI0002", address: "Jalan 1/3, Taman Tun Dr. Ismail", longitude: 3.133309, latitude: 101.626877, fill_level_id: 4, state_id: 2, city_id: 7, area_id: 1, raspberrypi_id: 2},
    {name: "TTDI Waste Center 3", code: "TTDI0003", address: "Jalan 1/4, Taman Tun Dr. Ismail", longitude: 3.135937, latitude: 101.624967, fill_level_id: 3, state_id: 2, city_id: 7, area_id: 1, raspberrypi_id: 3},
    {name: "PJ Waste Center 1", code: "PJ0001", address: "Jalan 1/2, Petaling Jaya", longitude: 3.124703, latitude: 101.610388, fill_level_id: 2, state_id: 1, city_id: 1, area_id: 1, raspberrypi_id: 4},
    {name: "PJ Waste Center 2", code: "PJ0002", address: "Jalan 1/3, Petaling Jaya", longitude: 3.117143, latitude: 101.612760, fill_level_id: 5, state_id: 1, city_id: 1, area_id: 1, raspberrypi_id: 5},
    {name: "PJ Waste Center 3", code: "PJ0003", address: "Jalan 1/4, Petaling Jaya", longitude: 3.115297, latitude: 101.606691, fill_level_id: 10, state_id: 1, city_id: 1, area_id: 1, raspberrypi_id: 6}
  ])

  UserDustbinAssignment.create!([
    {user_id: 3, dustbin_id: 1},
    {user_id: 3, dustbin_id: 2},
    {user_id: 3, dustbin_id: 3},
    {user_id: 4, dustbin_id: 4},
    {user_id: 4, dustbin_id: 5},
    {user_id: 4, dustbin_id: 6},
    {user_id: 5, dustbin_id: 1},
    {user_id: 5, dustbin_id: 2},
    {user_id: 5, dustbin_id: 3},
    {user_id: 5, dustbin_id: 4},
    {user_id: 5, dustbin_id: 5},
    {user_id: 5, dustbin_id: 6}
  ])


  DustbinStat.create!([
      {dustbin_id: 1, fill_level_id: 0},
      {dustbin_id: 1, fill_level_id: 2},
      {dustbin_id: 1, fill_level_id: 4},
      {dustbin_id: 1, fill_level_id: 8},
      {dustbin_id: 1, fill_level_id: 0},
      {dustbin_id: 2, fill_level_id: 0},
      {dustbin_id: 2, fill_level_id: 2},
      {dustbin_id: 2, fill_level_id: 4},
      {dustbin_id: 2, fill_level_id: 8},
      {dustbin_id: 2, fill_level_id: 0},
      {dustbin_id: 3, fill_level_id: 0},
      {dustbin_id: 3, fill_level_id: 3},
      {dustbin_id: 3, fill_level_id: 5},
      {dustbin_id: 3, fill_level_id: 7},
      {dustbin_id: 3, fill_level_id: 0},
      {dustbin_id: 4, fill_level_id: 0},
      {dustbin_id: 4, fill_level_id: 1},
      {dustbin_id: 4, fill_level_id: 1},
      {dustbin_id: 4, fill_level_id: 5},
      {dustbin_id: 4, fill_level_id: 0},
      {dustbin_id: 5, fill_level_id: 0},
      {dustbin_id: 5, fill_level_id: 2},
      {dustbin_id: 5, fill_level_id: 4},
      {dustbin_id: 5, fill_level_id: 8},
      {dustbin_id: 5, fill_level_id: 0},
      {dustbin_id: 6, fill_level_id: 0},
      {dustbin_id: 6, fill_level_id: 2},
      {dustbin_id: 6, fill_level_id: 4},
      {dustbin_id: 6, fill_level_id: 8},
      {dustbin_id: 6, fill_level_id: 0}
  ])



