FactoryBot.define do
  factory :bug do
  
    association :user_status, factory: :valid_user
    description "This is a bug's description"
    status :active
    date_status { Time.now }
  
    factory :valid_bug do
      association :project, factory: :valid_project
    end
    factory :another_valid_bug do
      association :project, factory: :valid_project
    end
    factory :valid_bug_of_another_valid_project do
      association :project, factory: :another_valid_project
    end

  end
end