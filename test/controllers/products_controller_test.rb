require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference("Product.count") do
      post products_url, params: { product: { ad_id: @product.ad_id, address: @product.address, age_in_months: @product.age_in_months, age_in_years: @product.age_in_years, breed: @product.breed, castrated: @product.castrated, category_id: @product.category_id, city: @product.city, country: @product.country, height: @product.height, long_description: @product.long_description, name: @product.name, price: @product.price, quantity: @product.quantity, self_stock: @product.self_stock, sex: @product.sex, short_description: @product.short_description, state: @product.state, status: @product.status, teeth: @product.teeth, user_id: @product.user_id, verified: @product.verified, veigth: @product.veigth } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { ad_id: @product.ad_id, address: @product.address, age_in_months: @product.age_in_months, age_in_years: @product.age_in_years, breed: @product.breed, castrated: @product.castrated, category_id: @product.category_id, city: @product.city, country: @product.country, height: @product.height, long_description: @product.long_description, name: @product.name, price: @product.price, quantity: @product.quantity, self_stock: @product.self_stock, sex: @product.sex, short_description: @product.short_description, state: @product.state, status: @product.status, teeth: @product.teeth, user_id: @product.user_id, verified: @product.verified, veigth: @product.veigth } }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference("Product.count", -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
