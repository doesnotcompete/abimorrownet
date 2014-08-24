FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name  "Doe"
    email "john.doe@example.com"
    admin false
  end

  # This will use the User class (Admin would have been guessed)
  factory :admin, class: User do
    admin true
  end

  factory :moderator, class: User do
    moderator true
  end

  factory :identity, class: User do
    provider "facebook"
    uid "12345"
  end
end
