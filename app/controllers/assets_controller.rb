class AssetsController < ApplicationController
  def create
    asset = Asset.new(asset_params)
    asset.save!
    render json: { url: asset.photo.url }
  end

  private

  def asset_params
    params.require(:asset).permit(:photo)
  end
end
