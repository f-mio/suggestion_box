# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

 Department.create([
  {id:0, name: '---',                parent_id: 0, layer: 0},
  {id:1, name: "本社",                parent_id: 1, layer: 1},
  {id:2, name: "本社 総務部",          parent_id: 2, layer: 2},
  {id:3, name: "本社 総務部 総務課",    parent_id: 2, layer: 3},
  {id:4, name: "A事業所",             parent_id: 4, layer: 1},
  {id:5, name: "α工場 製造部",         parent_id: 4, layer: 2},
  {id:6, name: "A工場 製造部 AA製造課", parent_id: 4, layer: 3},
  {id:7, name: "A工場 製造部 BB製造課", parent_id: 4, layer: 3},
   ])
 Location.create([
  {id:0, name: '---' },
  {id:1, name: "本社"},
  {id:2, name: "A事業所"},
])
Place.create([
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