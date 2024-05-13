require "application_system_test_case"

class PaidAdsTest < ApplicationSystemTestCase
  setup do
    @paid_ad = paid_ads(:one)
  end

  test "visiting the index" do
    visit paid_ads_url
    assert_selector "h1", text: "Paid ads"
  end

  test "should create paid ad" do
    visit paid_ads_url
    click_on "New paid ad"

    fill_in "Quantity", with: @paid_ad.quantity
    fill_in "Status", with: @paid_ad.status
    fill_in "User", with: @paid_ad.user_id
    click_on "Create Paid ad"

    assert_text "Paid ad was successfully created"
    click_on "Back"
  end

  test "should update Paid ad" do
    visit paid_ad_url(@paid_ad)
    click_on "Edit this paid ad", match: :first

    fill_in "Quantity", with: @paid_ad.quantity
    fill_in "Status", with: @paid_ad.status
    fill_in "User", with: @paid_ad.user_id
    click_on "Update Paid ad"

    assert_text "Paid ad was successfully updated"
    click_on "Back"
  end

  test "should destroy Paid ad" do
    visit paid_ad_url(@paid_ad)
    click_on "Destroy this paid ad", match: :first

    assert_text "Paid ad was successfully destroyed"
  end
end
