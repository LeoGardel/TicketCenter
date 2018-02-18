FactoryBot.define do
  factory :user do
    
    email { Faker::Internet.unique.email }
    password { Faker::Lorem.characters(15) }
    password_confirmation { password }
    date_of_birth {Faker::Date.birthday(18, 65) }
    
    factory :valid_user do
      name { Faker::Name.unique.name }
    end
    
    factory :invalid_user do
      #A name wasn't set
    end
    
  end
end