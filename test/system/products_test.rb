require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  setup do
    @product = products(:one)
  end

  test "visiting the index" do
    visit products_url
    assert_selector "h1", text: "Products"
  end

  test "should create product" do
    visit products_url
    click_on "New product"

    fill_in "Address", with: @product.address
    fill_in "Age", with: @product.age
    fill_in "Breed", with: @product.breed
    check "Castrated" if @product.castrated
    fill_in "Category", with: @product.category_id
    fill_in "City", with: @product.city
    fill_in "Country", with: @product.country
    fill_in "Height", with: @product.height
    fill_in "Long description", with: @product.long_description
    fill_in "Name", with: @product.name
    fill_in "Price", with: @product.price
    fill_in "Quantity", with: @product.quantity
    check "Self stock" if @product.self_stock
    fill_in "Sex", with: @product.sex
    fill_in "Short description", with: @product.short_description
    fill_in "State", with: @product.state
    fill_in "Status", with: @product.status
    fill_in "Teeth", with: @product.teeth
    fill_in "User", with: @product.user_id
    check "Verified" if @product.verified
    fill_in "veigth", with: @product.veigth
    click_on "Create Product"

    assert_text "Product was successfully created"
    click_on "Back"
  end

  test "should update Product" do
    visit product_url(@product)
    click_on "Edit this product", match: :first

    fill_in "Address", with: @product.address
    fill_in "Age", with: @product.age
    fill_in "Breed", with: @product.breed
    check "Castrated" if @product.castrated
    fill_in "Category", with: @product.category_id
    fill_in "City", with: @product.city
    fill_in "Country", with: @product.country
    fill_in "Height", with: @product.height
    fill_in "Long description", with: @product.long_description
    fill_in "Name", with: @product.name
    fill_in "Price", with: @product.price
    fill_in "Quantity", with: @product.quantity
    check "Self stock" if @product.self_stock
    fill_in "Sex", with: @product.sex
    fill_in "Short description", with: @product.short_description
    fill_in "State", with: @product.state
    fill_in "Status", with: @product.status
    fill_in "Teeth", with: @product.teeth
    fill_in "User", with: @product.user_id
    check "Verified" if @product.verified
    fill_in "veigth", with: @product.veigth
    click_on "Update Product"

    assert_text "Product was successfully updated"
    click_on "Back"
  end

  test "should destroy Product" do
    visit product_url(@product)
    click_on "Destroy this product", match: :first

    assert_text "Product was successfully destroyed"
  end
end
