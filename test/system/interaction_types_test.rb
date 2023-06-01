require "application_system_test_case"

class InteractionTypesTest < ApplicationSystemTestCase
  setup do
    @interaction_type = interaction_types(:one)
  end

  test "visiting the index" do
    visit interaction_types_url
    assert_selector "h1", text: "Interaction types"
  end

  test "should create interaction type" do
    visit interaction_types_url
    click_on "New interaction type"

    fill_in "Description", with: @interaction_type.description
    fill_in "Name", with: @interaction_type.name
    click_on "Create Interaction type"

    assert_text "Interaction type was successfully created"
    click_on "Back"
  end

  test "should update Interaction type" do
    visit interaction_type_url(@interaction_type)
    click_on "Edit this interaction type", match: :first

    fill_in "Description", with: @interaction_type.description
    fill_in "Name", with: @interaction_type.name
    click_on "Update Interaction type"

    assert_text "Interaction type was successfully updated"
    click_on "Back"
  end

  test "should destroy Interaction type" do
    visit interaction_type_url(@interaction_type)
    click_on "Destroy this interaction type", match: :first

    assert_text "Interaction type was successfully destroyed"
  end
end
