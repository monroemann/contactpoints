require "application_system_test_case"

class LastKnownCitiesTest < ApplicationSystemTestCase
  setup do
    @last_known_city = last_known_cities(:one)
  end

  test "visiting the index" do
    visit last_known_cities_url
    assert_selector "h1", text: "Last known cities"
  end

  test "should create last known city" do
    visit last_known_cities_url
    click_on "New last known city"

    fill_in "Name", with: @last_known_city.name
    click_on "Create Last known city"

    assert_text "Last known city was successfully created"
    click_on "Back"
  end

  test "should update Last known city" do
    visit last_known_city_url(@last_known_city)
    click_on "Edit this last known city", match: :first

    fill_in "Name", with: @last_known_city.name
    click_on "Update Last known city"

    assert_text "Last known city was successfully updated"
    click_on "Back"
  end

  test "should destroy Last known city" do
    visit last_known_city_url(@last_known_city)
    click_on "Destroy this last known city", match: :first

    assert_text "Last known city was successfully destroyed"
  end
end
