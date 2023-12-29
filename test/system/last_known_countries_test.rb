require "application_system_test_case"

class LastKnownCountriesTest < ApplicationSystemTestCase
  setup do
    @last_known_country = last_known_countries(:one)
  end

  test "visiting the index" do
    visit last_known_countries_url
    assert_selector "h1", text: "Last known countries"
  end

  test "should create last known country" do
    visit last_known_countries_url
    click_on "New last known country"

    fill_in "Name", with: @last_known_country.name
    click_on "Create Last known country"

    assert_text "Last known country was successfully created"
    click_on "Back"
  end

  test "should update Last known country" do
    visit last_known_country_url(@last_known_country)
    click_on "Edit this last known country", match: :first

    fill_in "Name", with: @last_known_country.name
    click_on "Update Last known country"

    assert_text "Last known country was successfully updated"
    click_on "Back"
  end

  test "should destroy Last known country" do
    visit last_known_country_url(@last_known_country)
    click_on "Destroy this last known country", match: :first

    assert_text "Last known country was successfully destroyed"
  end
end
