require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contact = contacts(:one)
  end

  test "should get index" do
    get contacts_url
    assert_response :success
  end

  test "should get new" do
    get new_contact_url
    assert_response :success
  end

  test "should create contact" do
    assert_difference("Contact.count") do
      post contacts_url, params: { contact: { address_1: @contact.address_1, address_2: @contact.address_2, areas_for_improvement: @contact.areas_for_improvement, best_memories: @contact.best_memories, birthday: @contact.birthday, contact_apps: @contact.contact_apps, email_1: @contact.email_1, email_2: @contact.email_2, email_3: @contact.email_3, email_4: @contact.email_4, email_5: @contact.email_5, first_name: @contact.first_name, home_phone: @contact.home_phone, how_we_met: @contact.how_we_met, last_known_city: @contact.last_known_city, last_known_country: @contact.last_known_country, last_name: @contact.last_name, mobile_phone_1: @contact.mobile_phone_1, mobile_phone_2: @contact.mobile_phone_2, notes: @contact.notes, office_phone_1: @contact.office_phone_1, office_phone_2: @contact.office_phone_2, other_phone: @contact.other_phone, things_I_like: @contact.things_I_like, website_1: @contact.website_1, website_2: @contact.website_2, website_3: @contact.website_3, website_4: @contact.website_4, website_5: @contact.website_5, website_6: @contact.website_6, website_7: @contact.website_7, website_8: @contact.website_8 } }
    end

    assert_redirected_to contact_url(Contact.last)
  end

  test "should show contact" do
    get contact_url(@contact)
    assert_response :success
  end

  test "should get edit" do
    get edit_contact_url(@contact)
    assert_response :success
  end

  test "should update contact" do
    patch contact_url(@contact), params: { contact: { address_1: @contact.address_1, address_2: @contact.address_2, areas_for_improvement: @contact.areas_for_improvement, best_memories: @contact.best_memories, birthday: @contact.birthday, contact_apps: @contact.contact_apps, email_1: @contact.email_1, email_2: @contact.email_2, email_3: @contact.email_3, email_4: @contact.email_4, email_5: @contact.email_5, first_name: @contact.first_name, home_phone: @contact.home_phone, how_we_met: @contact.how_we_met, last_known_city: @contact.last_known_city, last_known_country: @contact.last_known_country, last_name: @contact.last_name, mobile_phone_1: @contact.mobile_phone_1, mobile_phone_2: @contact.mobile_phone_2, notes: @contact.notes, office_phone_1: @contact.office_phone_1, office_phone_2: @contact.office_phone_2, other_phone: @contact.other_phone, things_I_like: @contact.things_I_like, website_1: @contact.website_1, website_2: @contact.website_2, website_3: @contact.website_3, website_4: @contact.website_4, website_5: @contact.website_5, website_6: @contact.website_6, website_7: @contact.website_7, website_8: @contact.website_8 } }
    assert_redirected_to contact_url(@contact)
  end

  test "should destroy contact" do
    assert_difference("Contact.count", -1) do
      delete contact_url(@contact)
    end

    assert_redirected_to contacts_url
  end
end
