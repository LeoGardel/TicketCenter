FactoryBot.define do
  factory :valid_user, class: User do
    
    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password { Faker::Lorem.characters(15) }
    password_confirmation { password }
    date_of_birth {Faker::Date.birthday(18, 65) }
    
  end
end