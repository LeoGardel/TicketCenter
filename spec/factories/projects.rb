FactoryBot.define do
  factory :project do
  
    association :manager, factory: :valid_user
    description "This is a project's description"
    start_date { Date.today }
  
    factory :valid_project do
      name "Valid Project"
      end_date {start_date+1}
    end
    factory :another_valid_project do
      name "Another Valid"
      end_date {start_date+1}
    end
    factory :project_with_invalid_dates do
      name "Invalid Dates"
      end_date {start_date-1}
    end

  end
end