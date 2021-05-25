# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

### これはテーブル構造を変えないと実装できない
#  Department.create([
#   {id:0, name: '---',                parent_id: 0, layer: 0},
#   {id:1, name: "本社",                parent_id: 1, layer: 1},
#   {id:2, name: "本社 総務部",          parent_id: 2, layer: 2},
#   {id:3, name: "本社 総務部 総務課",    parent_id: 2, layer: 3},
#   {id:4, name: "A事業所",             parent_id: 4, layer: 1},
#   {id:5, name: "α工場 製造部",         parent_id: 4, layer: 2},
#   {id:6, name: "A工場 製造部 AA製造課", parent_id: 4, layer: 3},
#   {id:7, name: "A工場 製造部 BB製造課", parent_id: 4, layer: 3},
#    ])
#########################################


Department.create([
  {id:0,   name: '---',                parent_id: 0},
  {id:100, name: "本社",                parent_id: 100},
  {id:110, name: "本社 総務部",          parent_id: 110},
  {id:111, name: "本社 総務部 総務課",    parent_id: 110},
  {id:200, name: "A事業所",             parent_id: 200 },
  {id:220, name: "A工場 製造部",         parent_id: 220},
  {id:221, name: "A工場 製造部 AA製造課", parent_id: 220},
  {id:222, name: "A工場 製造部 BB製造課", parent_id: 220},
])
Location.create([
  {id:0, name: '---' },
  {id:1, name: "本社"},
  {id:2, name: "A事業所"},
])
Place.create([
  {id:0, name: '---' ,   location_id: 0},
  {id:1, name: "本社1F", location_id: 1},
  {id:2, name: "本社2F", location_id: 1},
  {id:3, name: "本社3F", location_id: 1},
  {id:4, name: "α工場", location_id: 2},
  {id:5, name: "β工場", location_id: 2},
  {id:6, name: "事務棟", location_id: 2}
 ])
ResultList.create([
  {id: 0, name: '---' },
  {id: 1, name: "クローズ"},
  {id: 2, name: "他部門への情報共有"},
  {id: 3, name: "審査会対象"},
])
User.create([
 {id: 1, email: "root_user@abcd.co.jp", password: ENV['user_initial_pass'], password_confirmation: ENV['user_initial_pass'], family_name: "root", first_name:"userさん", corporate_no:"abcd2039000"},
 {id: 2, email: "abcd2021001@abcd.co.jp", password: ENV['user_initial_pass'], password_confirmation: ENV['user_initial_pass'], family_name: "総務課", first_name:"太郎", corporate_no:"abcd2021001"},
 {id: 3, email: "abcd2021002@abcd.co.jp", password: ENV['user_initial_pass'], password_confirmation: ENV['user_initial_pass'], family_name: "総務課", first_name:"二郎", corporate_no:"abcd2021002"},
 {id: 4, email: "abcd2021003@abcd.co.jp", password: ENV['user_initial_pass'], password_confirmation: ENV['user_initial_pass'], family_name: "総務課", first_name:"三郎", corporate_no:"abcd2021003"},
 {id: 5, email: "abcd1981001@abcd.co.jp", password: ENV['user_initial_pass'], password_confirmation: ENV['user_initial_pass'], family_name: "総務課", first_name:"課長", corporate_no:"abcd1981001"},
 {id: 6, email: "abcd1982001@abcd.co.jp", password: ENV['user_initial_pass'], password_confirmation: ENV['user_initial_pass'], family_name: "α工場製造", first_name:"製造部長", corporate_no:"abcd1982001"},
 {id: 7, email: "abcd1983001@abcd.co.jp", password: ENV['user_initial_pass'], password_confirmation: ENV['user_initial_pass'], family_name: "AA製造課", first_name:"課長", corporate_no:"abcd1983001"},
 {id: 8, email: "abcd1984001@abcd.co.jp", password: ENV['user_initial_pass'], password_confirmation: ENV['user_initial_pass'], family_name: "BB製造課", first_name:"課長", corporate_no:"abcd1984001"},
 {id: 9, email: "abcd1981002@abcd.co.jp", password: ENV['user_initial_pass'], password_confirmation: ENV['user_initial_pass'], family_name: "BB製造課", first_name:"課長補佐", corporate_no:"abcd1981002"},
 {id: 10, email: "abcd2021004@abcd.co.jp", password: ENV['user_initial_pass'], password_confirmation: ENV['user_initial_pass'], family_name: "AA製造課", first_name:"一郎", corporate_no:"abcd2021004"},
 {id: 11, email: "abcd2021005@abcd.co.jp", password: ENV['user_initial_pass'], password_confirmation: ENV['user_initial_pass'], family_name: "BB製造課", first_name:"一郎", corporate_no:"abcd2021005"},
])