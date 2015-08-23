class Asset < ActiveRecord::Base
  has_attached_file :photo, :styles => { original: "600x400^" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  belongs_to :post
end
