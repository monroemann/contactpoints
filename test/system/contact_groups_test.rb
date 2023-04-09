require "application_system_test_case"

class ContactGroupsTest < ApplicationSystemTestCase
  setup do
    @contact_group = contact_groups(:one)
  end

  test "visiting the index" do
    visit contact_groups_url
    assert_selector "h1", text: "Contact groups"
  end

  test "should create contact group" do
    visit contact_groups_url
    click_on "New contact group"

    fill_in "Description", with: @contact_group.description
    fill_in "Name", with: @contact_group.name
    click_on "Create Contact group"

    assert_text "Contact group was successfully created"
    click_on "Back"
  end

  test "should update Contact group" do
    visit contact_group_url(@contact_group)
    click_on "Edit this contact group", match: :first

    fill_in "Description", with: @contact_group.description
    fill_in "Name", with: @contact_group.name
    click_on "Update Contact group"

    assert_text "Contact group was successfully updated"
    click_on "Back"
  end

  test "should destroy Contact group" do
    visit contact_group_url(@contact_group)
    click_on "Destroy this contact group", match: :first

    assert_text "Contact group was successfully destroyed"
  end
end
