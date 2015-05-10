FactoryGirl.define do
  factory :account do
    provider "facebook"
    uid "1234"
    association :user
  end
end
