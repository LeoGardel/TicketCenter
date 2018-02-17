FactoryBot.define do
  factory :project do
  
    association :manager, factory: :valid_user
    description { Faker::Lorem.paragraph }
    start_date { Date.today }
    name { Faker::Name.unique.name }
  
    factory :valid_project do
      end_date { start_date + 1 }
    end
    factory :another_valid_project do
      end_date { start_date}
    end
    factory :project_with_invalid_dates do
      end_date { start_date - 1 }
    end

  end
end