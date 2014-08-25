FactoryGirl.define do
  factory :profile do
    first_name "John"
    last_name "Doe"

    trait :female do
      first_name "Jane"
      last_name "Doe"
    end

    trait :male do
    end
  end
end
