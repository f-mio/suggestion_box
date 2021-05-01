FactoryBot.define do
  factory :category do
    id = Category.plunk(:id)
    category = Category.find(id)

    id    {id}
    name  {category.name}
  end
end