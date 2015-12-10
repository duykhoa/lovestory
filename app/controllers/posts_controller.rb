class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i(show edit update destroy)
  load_and_authorize_resource

  layout 'love_pages'

  def new
    @love_page = love_page
    @post = Post.new
  end

  def create
    @post = love_page.posts.new(post_params.merge(user: current_user))
    @post.save

    if params.key?("photo_ids")
      photo_ids.split(",").each do |photo_id|
        asset = Asset.find_by_id(photo_id)
        asset.post_id = @post.id
        asset.save
      end
    end

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

    respond_to do |format|
      format.json { render json: { status: :success } }
      format.html { redirect_to love_page }
    end
  end

  private

  def set_post
    @post = Post.find_by_id post_id[:id]
  end

  def post_id
    params.permit(:id)
  end

  def love_page
    LovePage.friendly.find(love_page_param[:love_page_id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def photo_ids
    params.require("photo_ids")
  end

  def love_page_param
    params.permit(:love_page_id)
  end
end
