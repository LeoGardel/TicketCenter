FactoryBot.define do
  factory :bug do
    
    association :user_status, factory: :valid_user
    association :project, factory: :valid_project
    status :active
      
    factory :valid_bug do
      description { Faker::Lorem.paragraph }
    end
    factory :another_valid_bug do
      description { Faker::Lorem.paragraph }
    end
    factory :bug_with_undefined_description do
      description { nil }
    end
  end
end