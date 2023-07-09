require "application_system_test_case"

class InteractionCategoriesTest < ApplicationSystemTestCase
  setup do
    @interaction_category = interaction_categories(:one)
  end

  test "visiting the index" do
    visit interaction_categories_url
    assert_selector "h1", text: "Interaction categories"
  end

  test "should create interaction category" do
    visit interaction_categories_url
    click_on "New interaction category"

    fill_in "Description", with: @interaction_category.description
    fill_in "Name", with: @interaction_category.name
    click_on "Create Interaction category"

    assert_text "Interaction category was successfully created"
    click_on "Back"
  end

  test "should update Interaction category" do
    visit interaction_category_url(@interaction_category)
    click_on "Edit this interaction category", match: :first

    fill_in "Description", with: @interaction_category.description
    fill_in "Name", with: @interaction_category.name
    click_on "Update Interaction category"

    assert_text "Interaction category was successfully updated"
    click_on "Back"
  end

  test "should destroy Interaction category" do
    visit interaction_category_url(@interaction_category)
    click_on "Destroy this interaction category", match: :first

    assert_text "Interaction category was successfully destroyed"
  end
end
