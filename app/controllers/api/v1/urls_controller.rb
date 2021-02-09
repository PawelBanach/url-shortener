class Api::V1::UrlsController < ApplicationController

  def redirect
    @url = Url.find_by(key: key_param)
    if @url.present?
      @url.update_attribute(:clicked, @url.clicked + 1)
      redirect_to @url.source, status: :found
    else
      render_not_found
    end
  end

  def shorten
    url = Url.shorten(source: url_params[:source], custom_key: url_params[:custom_key])

    if url&.errors.blank?
      render json: { url: url.redirect_url }, status: :created
    else
      render json: { errors: url.errors.to_hash }, status: :unprocessable_entity
    end
  end

  private

  def url_params
    params.require(:url).permit(:source, :custom_key)
  end

  def key_param
    params.require(:key)
  end
end
