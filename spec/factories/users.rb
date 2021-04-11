FactoryBot.define do
  factory :user do

    email        { "aaa" + "@abcd.co.jp"}
    password     {Faker::Internet.password(min_length: 4) + 'aaa1'}
    password_confirmation {password}

    gimei = Gimei.name
    first_name   {gimei.first.kanji}
    family_name  {gimei.last.kanji}
    corporate_no { "abcd" + (Faker::Number.within(range: 1970..2039)).to_s + "001"}

  end
end