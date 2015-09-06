class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :fb_uid, :created_at, :user_id
  has_many :assets

  def assets
    object.assets.map { |asset| asset.photo.url }
  end

  def fb_uid
    object.user.uid
  end

  def user_id
    object.user.id
  end
end
