class LovePageSerializer < ActiveModel::Serializer
  attributes :id, :post_count, :created_at
  has_many :users

  def post_count
    object.posts.count
  end
end
