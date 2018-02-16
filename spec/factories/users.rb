FactoryBot.define do
  sequence(:email) { |n| "user_#{n}@factory.com" }
  sequence(:name) { |n| "User Number #{n}" }
  
  factory :user do
    
    factory :valid_user do
      name { generate(:name) }
      email { generate(:email) }
      password "123456"
      password_confirmation "123456"
    end

    date_of_birth "1960-01-01"
  end
end