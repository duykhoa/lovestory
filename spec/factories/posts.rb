FactoryGirl.define do
  factory :post do
    love_page
    user
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraphs(5).join("\r\n") }
  end
end
