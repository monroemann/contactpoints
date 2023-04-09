require "test_helper"

class ContactTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contact_type = contact_types(:one)
  end

  test "should get index" do
    get contact_types_url
    assert_response :success
  end

  test "should get new" do
    get new_contact_type_url
    assert_response :success
  end

  test "should create contact_type" do
    assert_difference("ContactType.count") do
      post contact_types_url, params: { contact_type: { name: @contact_type.name } }
    end

    assert_redirected_to contact_type_url(ContactType.last)
  end

  test "should show contact_type" do
    get contact_type_url(@contact_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_contact_type_url(@contact_type)
    assert_response :success
  end

  test "should update contact_type" do
    patch contact_type_url(@contact_type), params: { contact_type: { name: @contact_type.name } }
    assert_redirected_to contact_type_url(@contact_type)
  end

  test "should destroy contact_type" do
    assert_difference("ContactType.count", -1) do
      delete contact_type_url(@contact_type)
    end

    assert_redirected_to contact_types_url
  end
end
