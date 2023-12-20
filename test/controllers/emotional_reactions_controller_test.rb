require "test_helper"

class EmotionalReactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @emotional_reaction = emotional_reactions(:one)
  end

  test "should get index" do
    get emotional_reactions_url
    assert_response :success
  end

  test "should get new" do
    get new_emotional_reaction_url
    assert_response :success
  end

  test "should create emotional_reaction" do
    assert_difference("EmotionalReaction.count") do
      post emotional_reactions_url, params: { emotional_reaction: {  } }
    end

    assert_redirected_to emotional_reaction_url(EmotionalReaction.last)
  end

  test "should show emotional_reaction" do
    get emotional_reaction_url(@emotional_reaction)
    assert_response :success
  end

  test "should get edit" do
    get edit_emotional_reaction_url(@emotional_reaction)
    assert_response :success
  end

  test "should update emotional_reaction" do
    patch emotional_reaction_url(@emotional_reaction), params: { emotional_reaction: {  } }
    assert_redirected_to emotional_reaction_url(@emotional_reaction)
  end

  test "should destroy emotional_reaction" do
    assert_difference("EmotionalReaction.count", -1) do
      delete emotional_reaction_url(@emotional_reaction)
    end

    assert_redirected_to emotional_reactions_url
  end
end
