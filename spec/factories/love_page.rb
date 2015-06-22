FactoryGirl.define do
  factory :love_page do
    transient do
      user nil
    end

    after(:create) do |love_page, evaluator|
      create(:user_love_page, user: evaluator.user, love_page: love_page)
    end
  end
end
