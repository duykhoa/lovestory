require "rails_helper"

describe LovePage do
  it { should have_many(:posts) }
  it { should have_many(:user_love_pages) }
  it { should have_many(:users) }
end
