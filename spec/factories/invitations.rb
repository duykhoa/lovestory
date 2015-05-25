FactoryGirl.define do
  factory :invitation do
    association :love_page
    association :user
  end
end
