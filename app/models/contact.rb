class Contact < ApplicationRecord

  extend Pagy::ElasticsearchRails

  # after_save :update_points_after_interaction_and_leeching
  # before_save :leech_points

	validates :first_name, presence: true
  validates :last_name, presence: true

  belongs_to :user

	has_many :interactions, dependent: :destroy

	has_many :contact_categories, dependent: :destroy
  has_many :categories, through: :contact_categories

	has_many :contact_groupings, dependent: :destroy
	has_many :contact_groups, through: :contact_groupings

	has_many :contact_typings, dependent: :destroy
	has_many :contact_types, through: :contact_typings

  has_many :points
  has_many :interactions, through: :points

  has_many :contact_countries, dependent: :destroy
  has_many :last_known_countries, through: :contact_countries

  has_many :contact_cities, dependent: :destroy
  has_many :last_known_cities, through: :contact_cities

  #Automatically adds each new contact as Recently Added
  # after_create :assign_to_default_category

  def full_name
  "#{first_name} #{last_name}".strip
  end

  def known_since
    return 'Unknown' if date_first_met.nil?

    difference_in_days = (Date.today - date_first_met).to_i
    years = difference_in_days / 365
    months = (difference_in_days % 365) / 30

    result = if years > 0 && months > 0
      "#{years} #{'year'.pluralize(years)}, #{months} #{'month'.pluralize(months)}"
    elsif years > 0
      "#{years} #{'year'.pluralize(years)}"
    else
      "#{months} #{'month'.pluralize(months)}"
    end
  end

  def assign_to_default_category
    default_category = user.categories.find_by(id: 1)

    if default_category
      categories << default_category
    else
      Rails.logger.warn("Default category with ID 1 not found for contact #{id}")
      fallback_category = user.categories.first # Adjust this logic based on your needs
      categories << fallback_category if fallback_category
    end
  end

  def total_points
    interactions.sum(&:total_points)
  end

  def update_points
    new_points = total_points
    update_columns(points: new_points)
  end

  def self.ransackable_associations(auth_object = nil)
    ["category", "contact_groupings", "contact_groups", "contact_categories", 
      "contact_types", "contact_typings", "user", "points"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["address_1", "address_2", "areas_for_improvement", "best_memories", 
      "birthday", "contact_apps", "created_at", "email_1", "email_2", 
      "email_3", "email_4", "email_5", "first_name", "home_phone", "how_we_met", 
      "id", "last_known_city", "last_known_country", "last_name", "mobile_phone_1", 
      "mobile_phone_2", "notes", "office_phone_1", "office_phone_2", "other_phone", 
      "points", "things_I_like", "updated_at", "user_id", "website_1", "website_2", 
      "website_3", "website_4", "website_5", "website_6", "website_7", "website_8",
      "points"]
  end

  searchkick text_middle: [:first_name, :last_name, :last_known_country, :last_known_city]

  #LEECHING METHODS
def update_points_after_interaction_and_leeching
  # Debug output for leeching_days
  puts "Leeching days: #{leeching_days}"

  # Convert leeching_days to integer
  leeching_points = leeching_days.to_i * 1  # Assuming 1 point is leeched per day
  total_points = interactions.sum(&:total_points).to_i

  puts "Total points: #{total_points}"
  puts "Leeching points: #{leeching_points}"

  new_points = total_points - leeching_points
  puts "Before max operation: #{new_points}"
  new_points = [new_points, 0].max  # Ensure points don't go below 0
  puts "After max operation: #{new_points}"
  
  update(points: new_points)  

  puts "Updated points: #{new_points}"
end


def leech_points
  current_points = self[:points]
  puts "User ID: #{id} - Current points: #{current_points}"  # Debugging output with user ID
  
  if current_points <= 0 || leeching_today?
    puts "LEECH SKIPPED: User ID: #{id} - Last Leech Day: #{last_leeching_date} - Points: #{current_points}"
    return
  end
  
  puts "User ID: #{id} - Before decrement: #{current_points}"  # Debugging output with user ID
  
  update_columns(points: current_points - 1)
  
  puts "User ID: #{id} - After decrement: #{self[:points]}"  # Debugging output with user ID
  
  update(last_leeching_date: Date.today)
end






  def leeching_days
    (Date.today - created_at.to_date).to_i
  end

  def leeching_today?
    last_leeching_date == Date.today
  end

end
