namespace :image do
  task migrate: :environment do
    Image.delete_all
    Post.find_each do |post|
      post.assets.find_each do |asset|

        img = Image.new
        img_forrest = Upload::ImageForrest.new(asset.photo.path, "800").upload

        img.url = img_forrest.original_url
        img.thumb_url = img_forrest.url
        img.post_id = post.id
        img.save
      end
    end
  end
end
