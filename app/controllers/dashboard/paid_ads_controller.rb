class Dashboard::PaidAdsController < Dashboard::BaseController
  before_action :set_paid_ad, only: %i[ show edit update destroy ]

  # GET /paid_ads
  def index
    @paid_ads = current_user.paid_ads.page(page).per(per)
  end

  # GET /paid_ads/1 or /paid_ads/1.json
  def show
  end

  # GET /paid_ads/new
  def new
    @paid_ad = PaidAd.new
  end

  # GET /paid_ads/1/edit
  def edit; end

  # POST /paid_ads or /paid_ads.json
  def create
    @paid_ad = current_user.paid_ads.new(paid_ad_params)

      if @paid_ad.save
        redirect_to dashboard_paid_ads_path, notice: "Paid ad was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /paid_ads/1 or /paid_ads/1.json
  def update
    if @paid_ad.update(paid_ad_params)
      redirect_to dashboard_paid_ads_path, notice: "Paid ad was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /paid_ads/1 or /paid_ads/1.json
  def destroy
    @paid_ad.destroy!

    respond_to do |format|
      format.html { redirect_to paid_ads_url, notice: "Paid ad was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paid_ad
      @paid_ad = current_user.paid_ads.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def paid_ad_params
      params.require(:paid_ad).permit(:user_id, :quantity, :status, :ad_type, :payment_method)
    end
end
