class RecentPost
  PER = 25

  attr_reader :love_page
  # Constructor of RecentPost Class
  #
  # love_page - A lovepage that user want to get all page's posts
  #
  def initialize(love_page)
    @love_page = love_page
  end

  # Public: get posts in page #no
  #
  # no - A Interger page number that user want to get
  #
  # Examples
  #
  #    RecentPost.new(love_page).page(1)
  #    #=> <ActiveRecord::AssociationRelation[....]>
  #
  # Returns an array of post
  # TODO: Refactor it please
  def page(no = 1)
    love_page
      .posts
      .includes(:assets, :user)
      .limit(PER)
      .offset(offset(no))
  end

  private

  def offset(no = 1)
    no ? (no - 1) * PER : 0
  end
end
