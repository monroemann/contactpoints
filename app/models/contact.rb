class Contact < ApplicationRecord

	belongs_to :user

	has_many :interactions

	has_many :contact_categories, dependent: :destroy
  has_many :categories, through: :contact_categories

	has_many :contact_groupings, dependent: :destroy
	has_many :contact_groups, through: :contact_groupings

	has_many :contact_typings, dependent: :destroy
	has_many :contact_types, through: :contact_typings

  #Automatically adds each new contact as Recently Added
  after_create :assign_to_default_category

  def assign_to_default_category
    default_category = user.categories.find_by(id: 1)

    if default_category
      categories << default_category
    else
      # Handle the case where the default category with ID 1 is not found
      # You may want to log a warning or handle it in a way that fits your application
    end
  end

  # Uncomment to make the search bar work; but it keeps causing faraday issues on new contacts
	def self.ransackable_associations(auth_object = nil)
    ["category", "contact_groupings", "contact_groups", "contact_categories", 
      "contact_types", "contact_typings", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["address_1", "address_2", "areas_for_improvement", "best_memories", 
      "birthday", "contact_apps", "created_at", "email_1", "email_2", 
      "email_3", "email_4", "email_5", "first_name", "home_phone", "how_we_met", 
      "id", "last_known_city", "last_known_country", "last_name", "mobile_phone_1", 
      "mobile_phone_2", "notes", "office_phone_1", "office_phone_2", "other_phone", 
      "points", "things_I_like", "updated_at", "user_id", "website_1", "website_2", 
      "website_3", "website_4", "website_5", "website_6", "website_7", "website_8"]
  end

  searchkick text_middle: [:first_name, :last_name, :last_known_country, :last_known_city]

end
