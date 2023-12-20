require "application_system_test_case"

class EmotionalReactionsTest < ApplicationSystemTestCase
  setup do
    @emotional_reaction = emotional_reactions(:one)
  end

  test "visiting the index" do
    visit emotional_reactions_url
    assert_selector "h1", text: "Emotional reactions"
  end

  test "should create emotional reaction" do
    visit emotional_reactions_url
    click_on "New emotional reaction"

    click_on "Create Emotional reaction"

    assert_text "Emotional reaction was successfully created"
    click_on "Back"
  end

  test "should update Emotional reaction" do
    visit emotional_reaction_url(@emotional_reaction)
    click_on "Edit this emotional reaction", match: :first

    click_on "Update Emotional reaction"

    assert_text "Emotional reaction was successfully updated"
    click_on "Back"
  end

  test "should destroy Emotional reaction" do
    visit emotional_reaction_url(@emotional_reaction)
    click_on "Destroy this emotional reaction", match: :first

    assert_text "Emotional reaction was successfully destroyed"
  end
end
