class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :fb_uid, :created_at
  has_many :assets

  def assets
    object.assets.map { |asset| asset.photo.url }
  end

  def fb_uid
    object.user.uid
  end
end
