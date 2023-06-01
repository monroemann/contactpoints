require "test_helper"

class InteractionTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @interaction_type = interaction_types(:one)
  end

  test "should get index" do
    get interaction_types_url
    assert_response :success
  end

  test "should get new" do
    get new_interaction_type_url
    assert_response :success
  end

  test "should create interaction_type" do
    assert_difference("InteractionType.count") do
      post interaction_types_url, params: { interaction_type: { description: @interaction_type.description, name: @interaction_type.name } }
    end

    assert_redirected_to interaction_type_url(InteractionType.last)
  end

  test "should show interaction_type" do
    get interaction_type_url(@interaction_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_interaction_type_url(@interaction_type)
    assert_response :success
  end

  test "should update interaction_type" do
    patch interaction_type_url(@interaction_type), params: { interaction_type: { description: @interaction_type.description, name: @interaction_type.name } }
    assert_redirected_to interaction_type_url(@interaction_type)
  end

  test "should destroy interaction_type" do
    assert_difference("InteractionType.count", -1) do
      delete interaction_type_url(@interaction_type)
    end

    assert_redirected_to interaction_types_url
  end
end
