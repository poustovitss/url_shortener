class UrlsController < ApplicationController
  before_action :set_url, only: :show

  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)

    if @url.save
      redirect_to url_path(@url.unique_hash), notice: 'Url was successfully shortened!'
    else
      render :new
    end
  end

  def show
  end

  private
  def url_params
    params.require(:url).permit(:original_url)
  end

  def set_url
    @url = Url.where(unique_hash: params[:unique_hash]).first
  end
end
