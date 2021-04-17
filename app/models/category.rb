class Category < ActiveHash::Base
  self.data = [
    {id: 0, name: "---"},
    {id: 1, name: "コスト削減"},
    {id: 2, name: "作業効率化"},
    {id: 3, name: "安全"},
    {id: 4, name: "5S"},
    {id: 5, name: "その他"}
  ]

  include ActiveHash::Associations
  has_many :suggestions
end