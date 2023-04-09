require "application_system_test_case"

class ContactsTest < ApplicationSystemTestCase
  setup do
    @contact = contacts(:one)
  end

  test "visiting the index" do
    visit contacts_url
    assert_selector "h1", text: "Contacts"
  end

  test "should create contact" do
    visit contacts_url
    click_on "New contact"

    fill_in "Address 1", with: @contact.address_1
    fill_in "Address 2", with: @contact.address_2
    fill_in "Areas for improvement", with: @contact.areas_for_improvement
    fill_in "Best memories", with: @contact.best_memories
    fill_in "Birthday", with: @contact.birthday
    fill_in "Contact apps", with: @contact.contact_apps
    fill_in "Email 1", with: @contact.email_1
    fill_in "Email 2", with: @contact.email_2
    fill_in "Email 3", with: @contact.email_3
    fill_in "Email 4", with: @contact.email_4
    fill_in "Email 5", with: @contact.email_5
    fill_in "First name", with: @contact.first_name
    fill_in "Home phone", with: @contact.home_phone
    fill_in "How we met", with: @contact.how_we_met
    fill_in "Last known city", with: @contact.last_known_city
    fill_in "Last known country", with: @contact.last_known_country
    fill_in "Last name", with: @contact.last_name
    fill_in "Mobile phone 1", with: @contact.mobile_phone_1
    fill_in "Mobile phone 2", with: @contact.mobile_phone_2
    fill_in "Notes", with: @contact.notes
    fill_in "Office phone 1", with: @contact.office_phone_1
    fill_in "Office phone 2", with: @contact.office_phone_2
    fill_in "Other phone", with: @contact.other_phone
    fill_in "Things i like", with: @contact.things_I_like
    fill_in "Website 1", with: @contact.website_1
    fill_in "Website 2", with: @contact.website_2
    fill_in "Website 3", with: @contact.website_3
    fill_in "Website 4", with: @contact.website_4
    fill_in "Website 5", with: @contact.website_5
    fill_in "Website 6", with: @contact.website_6
    fill_in "Website 7", with: @contact.website_7
    fill_in "Website 8", with: @contact.website_8
    click_on "Create Contact"

    assert_text "Contact was successfully created"
    click_on "Back"
  end

  test "should update Contact" do
    visit contact_url(@contact)
    click_on "Edit this contact", match: :first

    fill_in "Address 1", with: @contact.address_1
    fill_in "Address 2", with: @contact.address_2
    fill_in "Areas for improvement", with: @contact.areas_for_improvement
    fill_in "Best memories", with: @contact.best_memories
    fill_in "Birthday", with: @contact.birthday
    fill_in "Contact apps", with: @contact.contact_apps
    fill_in "Email 1", with: @contact.email_1
    fill_in "Email 2", with: @contact.email_2
    fill_in "Email 3", with: @contact.email_3
    fill_in "Email 4", with: @contact.email_4
    fill_in "Email 5", with: @contact.email_5
    fill_in "First name", with: @contact.first_name
    fill_in "Home phone", with: @contact.home_phone
    fill_in "How we met", with: @contact.how_we_met
    fill_in "Last known city", with: @contact.last_known_city
    fill_in "Last known country", with: @contact.last_known_country
    fill_in "Last name", with: @contact.last_name
    fill_in "Mobile phone 1", with: @contact.mobile_phone_1
    fill_in "Mobile phone 2", with: @contact.mobile_phone_2
    fill_in "Notes", with: @contact.notes
    fill_in "Office phone 1", with: @contact.office_phone_1
    fill_in "Office phone 2", with: @contact.office_phone_2
    fill_in "Other phone", with: @contact.other_phone
    fill_in "Things i like", with: @contact.things_I_like
    fill_in "Website 1", with: @contact.website_1
    fill_in "Website 2", with: @contact.website_2
    fill_in "Website 3", with: @contact.website_3
    fill_in "Website 4", with: @contact.website_4
    fill_in "Website 5", with: @contact.website_5
    fill_in "Website 6", with: @contact.website_6
    fill_in "Website 7", with: @contact.website_7
    fill_in "Website 8", with: @contact.website_8
    click_on "Update Contact"

    assert_text "Contact was successfully updated"
    click_on "Back"
  end

  test "should destroy Contact" do
    visit contact_url(@contact)
    click_on "Destroy this contact", match: :first

    assert_text "Contact was successfully destroyed"
  end
end
