class Interaction < ApplicationRecord

	belongs_to :user
	belongs_to :contact
  belongs_to :location
	belongs_to :interaction_type

	validates :user, presence: true

	has_many :interact_interact_categories, dependent: :destroy
	has_many :interaction_categories, through: :interact_interact_categories

	has_many :interaction_emotional_reactions, dependent: :destroy
	has_many :emotional_reactions, through: :interaction_emotional_reactions

  has_many :points, dependent: :destroy
  has_many :contacts, through: :points

 	def contact_full_name
    "#{contact.first_name} #{contact.last_name}" if contact.present?
  end

  #points code

  def total_points
    points.sum(&:total_points)
  end

  def update_points
    puts " ******* Updating points for interaction #{id} *********"

    points.destroy_all
    points.create(
      interaction: self,
      contact_id: contact_id,
      interaction_type_points: calculate_points_for_interaction_type,
      interaction_length_points: calculate_points_for_interaction_length,
      emotional_reactions_points: calculate_points_for_emotional_reactions,
      who_initiated_contact_points: calculate_points_for_who_initiated_contact
    )
  end

  def calculate_points_for_interaction_length
    case length
    when 'less than 5 min' then 1
    when '15 min' then 3
    when '30 min' then 5
    when '45 min' then 7
    when '1 hour' then 9
    when '2 hours' then 11
    when 'Half Day' then 13
    when 'Full Day' then 15
    when 'Overnight, Two-Day Adventure, or Weekend' then 17
    when 'Full-On Vacation' then 20
    else 0
    end
  end

  private

  def calculate_points_based_on_attributes
    interaction_points = 0

    interaction_points += calculate_points_for_interaction_type
    interaction_points += calculate_points_for_interaction_length
    interaction_points += calculate_points_for_emotional_reactions
    interaction_points += calculate_points_for_who_initiated_contact

    interaction_points
  end

  def calculate_points_for_interaction_type
    case interaction_type&.name
    when 'Social Media Chat' then 1
    when 'Text Conversation' then 2
    when 'Phone Call' then 4
    when 'Video Call' then 7
    when 'In Person Meeting' then 10
    when 'Greeting Card or Post Card' then 11
    when 'Typed Letter' then 12
    when 'Handwritten Letter - 1 page' then 15
    when 'Handwritten Letter - More than 1 page' then 20
    else 0
    end
  end

  def calculate_points_for_emotional_reactions

    positive_emotions = ['Happy', 'Excited', 'Calm', 'Trusting', 'Inspired', 'Motivated', 
                          'Smiling', 'Laughing', 'Optimistic', 'Creative', 'Energized', 
                          'Joyful', 'Values', 'Appreciated', 'Grateful', 'Appreciative', 
                          'Loved', 'Desired', 'Special', 'Smart', 'Intellectual', 'Problems Solved', 
                          'Like a Winner', 'Shazam', 'Listened To', 'Cheered Up']
    
    negative_emotions = ['Angry', 'Disappointed', 'Sad', 'Frustrated', 'Let Down', 'Abandoned', 
                        'Confused', 'Pessimistic', 'Depressed', 'Hopeless',  'Problems Created', 
                        'Emotionally Tired', 'Depleted', 'Empty', 'Bitter', 'Used', 'Like a Loser', 
                        'Needed', 'Needy', 'Anxious', 'Overwhelmed', 'Smothered', 'Depleted', 
                        'Empty', 'Bitter', 'Used', 'Like a Loser']

    points = 0

    emotional_reactions.each do |emotion|
      if positive_emotions.include?(emotion.name)
        points += 2
      elsif negative_emotions.include?(emotion.name)
        points -= 1
      end
    end

    points
  end

  def calculate_points_for_who_initiated_contact
    you_initiated_contact == true ? 1 : 3
  end

end
