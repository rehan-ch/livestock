require "test_helper"

class PaidAdsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @paid_ad = paid_ads(:one)
  end

  test "should get index" do
    get paid_ads_url
    assert_response :success
  end

  test "should get new" do
    get new_paid_ad_url
    assert_response :success
  end

  test "should create paid_ad" do
    assert_difference("PaidAd.count") do
      post paid_ads_url, params: { paid_ad: { quantity: @paid_ad.quantity, status: @paid_ad.status, user_id: @paid_ad.user_id } }
    end

    assert_redirected_to paid_ad_url(PaidAd.last)
  end

  test "should show paid_ad" do
    get paid_ad_url(@paid_ad)
    assert_response :success
  end

  test "should get edit" do
    get edit_paid_ad_url(@paid_ad)
    assert_response :success
  end

  test "should update paid_ad" do
    patch paid_ad_url(@paid_ad), params: { paid_ad: { quantity: @paid_ad.quantity, status: @paid_ad.status, user_id: @paid_ad.user_id } }
    assert_redirected_to paid_ad_url(@paid_ad)
  end

  test "should destroy paid_ad" do
    assert_difference("PaidAd.count", -1) do
      delete paid_ad_url(@paid_ad)
    end

    assert_redirected_to paid_ads_url
  end
end
