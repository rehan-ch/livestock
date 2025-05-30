class Admin::PaidAdsController < Admin::BaseController
  before_action :set_paid_ad, only: %i[show edit update destroy approve reject]

  def index
    @paid_ads = PaidAd.includes(:user).page(page).per(per)
    
    if params[:status].present? && params[:status].downcase != 'all'
      @paid_ads = @paid_ads.where(status: params[:status])
    end

    if params[:search].present?
      @paid_ads = @paid_ads.joins(:user).where("users.name ILIKE ? OR paid_ads.id::text ILIKE ?", 
        "%#{params[:search]}%", "%#{params[:search]}%")
    end
  end

  def show; end

  def edit; end

  def update
    if @paid_ad.update(paid_ad_params)
      redirect_to admin_paid_ad_path(@paid_ad), notice: "Paid ad was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @paid_ad.destroy!
    redirect_to admin_paid_ads_path, notice: "Paid ad was successfully destroyed."
  end

  def approve
    if @paid_ad.update(status: :approved)
      @paid_ad.user.update(number_of_ads: @paid_ad.user.number_of_ads + @paid_ad.quantity)
      redirect_to admin_paid_ad_path(@paid_ad), notice: "Advertisement was successfully approved."
    else
      redirect_to admin_paid_ad_path(@paid_ad), alert: "Failed to approve advertisement."
    end
  end

  def reject
    if @paid_ad.update(status: :rejected)
      redirect_to admin_paid_ad_path(@paid_ad), notice: "Advertisement was successfully rejected."
    else
      redirect_to admin_paid_ad_path(@paid_ad), alert: "Failed to reject advertisement."
    end
  end

  private

  def set_paid_ad
    @paid_ad = PaidAd.find(params[:id])
  end

  def paid_ad_params
    params.require(:paid_ad).permit(:quantity, :status, :ad_type, :payment_method)
  end
end 