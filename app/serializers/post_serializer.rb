class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content
  has_many :assets
end
