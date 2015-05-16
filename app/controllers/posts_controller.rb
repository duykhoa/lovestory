class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i(edit update destroy)

  def new
    @post = Post.new
  end

  def create
    love_page.posts.create(post_params)

    redirect_to love_page
  end

  def edit
  end

  def update
    @post.update(post_params)

    redirect_to love_page
  end

  def destroy
    @post.update(post_params)

    redirect_to love_page
  end

  private

  def set_post
    @post = Post.find_by_id post_id
  end

  def post_id
    params.permit(:id)
  end

  def love_page
    current_user.love_page
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
