class FilterResult < ActiveHash::Base
  self.data = [
    {id: 0,  name: "---"},
    {id: 99, name: "未評価"},
    {id: 1,  name: "クローズ"},
    {id: 2,  name: "他部門への情報共有"},
    {id: 3,  name: "審査会対象"},
  ]
end