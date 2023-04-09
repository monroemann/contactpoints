require "application_system_test_case"

class ContactTypesTest < ApplicationSystemTestCase
  setup do
    @contact_type = contact_types(:one)
  end

  test "visiting the index" do
    visit contact_types_url
    assert_selector "h1", text: "Contact types"
  end

  test "should create contact type" do
    visit contact_types_url
    click_on "New contact type"

    fill_in "Name", with: @contact_type.name
    click_on "Create Contact type"

    assert_text "Contact type was successfully created"
    click_on "Back"
  end

  test "should update Contact type" do
    visit contact_type_url(@contact_type)
    click_on "Edit this contact type", match: :first

    fill_in "Name", with: @contact_type.name
    click_on "Update Contact type"

    assert_text "Contact type was successfully updated"
    click_on "Back"
  end

  test "should destroy Contact type" do
    visit contact_type_url(@contact_type)
    click_on "Destroy this contact type", match: :first

    assert_text "Contact type was successfully destroyed"
  end
end
