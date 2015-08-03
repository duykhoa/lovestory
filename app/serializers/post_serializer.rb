class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content
  has_many :assets

  def assets
    object.assets.map { |asset| asset.photo.url }
  end
end
