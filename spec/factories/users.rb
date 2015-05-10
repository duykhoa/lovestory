FactoryGirl.define do
  factory :user do
    name ""
    sequence :email do
      |i| "user#{i}@gmail.com"
    end
    password "1234567890"

    association :accounts
  end
end
