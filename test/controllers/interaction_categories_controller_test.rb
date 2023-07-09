require "test_helper"

class InteractionCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @interaction_category = interaction_categories(:one)
  end

  test "should get index" do
    get interaction_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_interaction_category_url
    assert_response :success
  end

  test "should create interaction_category" do
    assert_difference("InteractionCategory.count") do
      post interaction_categories_url, params: { interaction_category: { description: @interaction_category.description, name: @interaction_category.name } }
    end

    assert_redirected_to interaction_category_url(InteractionCategory.last)
  end

  test "should show interaction_category" do
    get interaction_category_url(@interaction_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_interaction_category_url(@interaction_category)
    assert_response :success
  end

  test "should update interaction_category" do
    patch interaction_category_url(@interaction_category), params: { interaction_category: { description: @interaction_category.description, name: @interaction_category.name } }
    assert_redirected_to interaction_category_url(@interaction_category)
  end

  test "should destroy interaction_category" do
    assert_difference("InteractionCategory.count", -1) do
      delete interaction_category_url(@interaction_category)
    end

    assert_redirected_to interaction_categories_url
  end
end
