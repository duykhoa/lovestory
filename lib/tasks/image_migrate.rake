namespace :image do
  task migrate: :environment do
    Post.find_each do |post|
      post.assets.find_each do |asset|
        Image.delete_all

        img = Image.new
        img_forrest = Upload::ImageForrest.new(asset.photo.path, "800").upload

        img.url = img_forrest.original_url
        img.thumb_url = img_forrest.url

        post.images << img
        post.save
      end
    end
  end
end
