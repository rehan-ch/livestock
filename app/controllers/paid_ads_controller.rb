class PaidAdsController < ApplicationController
  before_action :set_paid_ad, only: %i[ show edit update destroy ]

  # GET /paid_ads/1 or /paid_ads/1.json
  def show
  end

  # GET /paid_ads/new
  def new
    @paid_ad = PaidAd.new
  end

  # GET /paid_ads/1/edit
  def edit
  end

  # POST /paid_ads or /paid_ads.json
  def create
    @paid_ad = PaidAd.new(paid_ad_params)

    respond_to do |format|
      if @paid_ad.save
        format.html { redirect_to paid_ad_url(@paid_ad), notice: "Paid ad was successfully created." }
        format.json { render :show, status: :created, location: @paid_ad }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @paid_ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /paid_ads/1 or /paid_ads/1.json
  def update
    respond_to do |format|
      if @paid_ad.update(paid_ad_params)
        format.html { redirect_to paid_ad_url(@paid_ad), notice: "Paid ad was successfully updated." }
        format.json { render :show, status: :ok, location: @paid_ad }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @paid_ad.errors, status: :unprocessable_entity }
      end
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
      @paid_ad = PaidAd.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def paid_ad_params
      params.require(:paid_ad).permit(:user_id, :quantity, :status)
    end
end
