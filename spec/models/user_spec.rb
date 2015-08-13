require "rails_helper"

describe User do
  it { should have_many(:love_pages).through(:user_love_pages) }
end
