class Admin::SocialMediaLinksController < Admin::BaseController
  before_action :set_social_media_link, only: [:show, :edit, :update, :destroy]

  def index
    @social_media_links = SocialMediaLink.all.order(:platform)
  end

  def show
  end

  def new
    @social_media_link = SocialMediaLink.new
  end

  def edit
  end

  def create
    @social_media_link = SocialMediaLink.new(social_media_link_params)

    if @social_media_link.save
      redirect_to admin_social_media_links_path, notice: 'Social media link was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @social_media_link.update(social_media_link_params)
      redirect_to admin_social_media_links_path, notice: 'Social media link was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @social_media_link.destroy
    redirect_to admin_social_media_links_path, notice: 'Social media link was successfully deleted.'
  end

  private

  def set_social_media_link
    @social_media_link = SocialMediaLink.find(params[:id])
  end

  def social_media_link_params
    params.require(:social_media_link).permit(:platform, :url, :icon_class, :active)
  end
end
