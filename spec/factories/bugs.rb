FactoryBot.define do
  factory :valid_bug, class: Bug do
  
    association :user_status, factory: :valid_user
    description { Faker::Lorem.paragraph }
    status :active
    date_status { Time.now }
    association :project, factory: :valid_project
  
  end
end