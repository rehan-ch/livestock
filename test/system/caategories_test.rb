require "application_system_test_case"

class CaategoriesTest < ApplicationSystemTestCase
  setup do
    @caategory = caategories(:one)
  end

  test "visiting the index" do
    visit caategories_url
    assert_selector "h1", text: "Caategories"
  end

  test "should create caategory" do
    visit caategories_url
    click_on "New caategory"

    fill_in "Description", with: @caategory.description
    fill_in "Name", with: @caategory.name
    click_on "Create Caategory"

    assert_text "Caategory was successfully created"
    click_on "Back"
  end

  test "should update Caategory" do
    visit caategory_url(@caategory)
    click_on "Edit this caategory", match: :first

    fill_in "Description", with: @caategory.description
    fill_in "Name", with: @caategory.name
    click_on "Update Caategory"

    assert_text "Caategory was successfully updated"
    click_on "Back"
  end

  test "should destroy Caategory" do
    visit caategory_url(@caategory)
    click_on "Destroy this caategory", match: :first

    assert_text "Caategory was successfully destroyed"
  end
end
