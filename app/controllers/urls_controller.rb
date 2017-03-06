class UrlsController < ApplicationController
  before_action :set_url, only: [:show, :shortened]

  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)

    if UniqueHashGeneratorService.new(@url).try_to_create_model
      redirect_to url_path(@url.unique_hash),
                  notice: 'Url was successfully shortened!'
    else
      render :new, notice: @url.errors
    end
  end

  def show; end

  def shortened
    if @url
      redirect_to @url.original_url
    else
      render file: "#{Rails.root}/public/404", layout: false, status: :not_found
    end
  end

  private

  def url_params
    params.require(:url).permit(:original_url)
  end

  def set_url
    @url = Url.where(unique_hash: params[:unique_hash]).first
  end
end
