FactoryBot.define do
  factory :location do
    id = Location.plunk(:id)
    location = Location.find(id)

    id    {id}
    name  {location.name}

  end
end
