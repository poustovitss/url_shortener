class UrlsController < ApplicationController
  def new
    @url = Url.new
  end

  def create
    @url = Url.create(url_params)
  end

  private
  def url_params
    params.require(:url).permit(:original_url)
  end
end
