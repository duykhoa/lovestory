class Ability
  include CanCan::Ability

  def initialize(user)
     user ||= User.new
     alias_action :read, :update, to: :ru

     can :ru, LovePage do |love_page|
       love_page.id.in? user.user_love_pages.pluck :love_page_id
     end

     can :create, LovePage

     can :manage, Post do |post|
       user
         .love_pages
         .joins(:posts)
         .pluck(:id)
         .include? post.id
     end
  end
end
