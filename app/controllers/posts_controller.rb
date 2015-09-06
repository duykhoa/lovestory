class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i(show edit update destroy)
  load_and_authorize_resource

  layout 'love_pages'

  def new
    @love_page = love_page
    @post = Post.new
    @post.assets.build
  end

  def create
    @post = love_page.posts.new(post_params.merge(user: current_user))
    @post.save

    redirect_to love_page
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end

  def edit
    @love_page = love_page
  end

  def update
    @post.update(post_params)

    redirect_to love_page
  end

  def destroy
    @post.destroy

    redirect_to love_page
  end

  private

  def set_post
    @post = Post.find_by_id post_id[:id]
  end

  def post_id
    params.permit(:id)
  end

  def love_page
    LovePage.find_by_id(love_page_param[:love_page_id])
  end

  def post_params
    params.require(:post).permit(:title, :content, assets_attributes: [:photo])
  end

  def love_page_param
    params.permit(:love_page_id)
  end
end
