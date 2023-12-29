require "test_helper"

class LastKnownCountriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @last_known_country = last_known_countries(:one)
  end

  test "should get index" do
    get last_known_countries_url
    assert_response :success
  end

  test "should get new" do
    get new_last_known_country_url
    assert_response :success
  end

  test "should create last_known_country" do
    assert_difference("LastKnownCountry.count") do
      post last_known_countries_url, params: { last_known_country: { name: @last_known_country.name } }
    end

    assert_redirected_to last_known_country_url(LastKnownCountry.last)
  end

  test "should show last_known_country" do
    get last_known_country_url(@last_known_country)
    assert_response :success
  end

  test "should get edit" do
    get edit_last_known_country_url(@last_known_country)
    assert_response :success
  end

  test "should update last_known_country" do
    patch last_known_country_url(@last_known_country), params: { last_known_country: { name: @last_known_country.name } }
    assert_redirected_to last_known_country_url(@last_known_country)
  end

  test "should destroy last_known_country" do
    assert_difference("LastKnownCountry.count", -1) do
      delete last_known_country_url(@last_known_country)
    end

    assert_redirected_to last_known_countries_url
  end
end
