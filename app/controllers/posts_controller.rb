class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    love_page.posts.create(post_params)

    redirect_to love_page
  end

  def update
  end

  def edit
  end

  def destroy
  end

  private

  def love_page
    current_user.love_page
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
