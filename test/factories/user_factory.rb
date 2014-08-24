FactoryGirl.define do
  factory :user do
    email "john.doe@example.com"
    password "test1234"
    association :profile
    admin false

    factory :identified_user do
      provider "facebook"
      uid "12345"
    end
  end

  # This will use the User class (Admin would have been guessed)
  factory :admin, class: User do
    admin true
  end

  factory :moderator, class: User do
    moderator true
  end
end
