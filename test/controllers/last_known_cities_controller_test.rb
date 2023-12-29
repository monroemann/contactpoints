require "test_helper"

class LastKnownCitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @last_known_city = last_known_cities(:one)
  end

  test "should get index" do
    get last_known_cities_url
    assert_response :success
  end

  test "should get new" do
    get new_last_known_city_url
    assert_response :success
  end

  test "should create last_known_city" do
    assert_difference("LastKnownCity.count") do
      post last_known_cities_url, params: { last_known_city: { name: @last_known_city.name } }
    end

    assert_redirected_to last_known_city_url(LastKnownCity.last)
  end

  test "should show last_known_city" do
    get last_known_city_url(@last_known_city)
    assert_response :success
  end

  test "should get edit" do
    get edit_last_known_city_url(@last_known_city)
    assert_response :success
  end

  test "should update last_known_city" do
    patch last_known_city_url(@last_known_city), params: { last_known_city: { name: @last_known_city.name } }
    assert_redirected_to last_known_city_url(@last_known_city)
  end

  test "should destroy last_known_city" do
    assert_difference("LastKnownCity.count", -1) do
      delete last_known_city_url(@last_known_city)
    end

    assert_redirected_to last_known_cities_url
  end
end
