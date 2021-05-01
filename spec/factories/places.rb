FactoryBot.define do
  factory :place do
    id = Place.plunk(:id)
    place = Place.find(id)

    id    {id}
    name  {place.name}

    association :location
  end
end
