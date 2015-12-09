class AssetsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    asset = Asset.new(photo: asset_params.tempfile)
    asset.save!

    render json: { id: asset.id, photo_url: asset.photo.url }
  end

  private

  def asset_params
    params[:file]
  end
end
