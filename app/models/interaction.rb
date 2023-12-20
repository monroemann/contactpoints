class Interaction < ApplicationRecord

		belongs_to :user
		belongs_to :contact
		belongs_to :interaction_type

		validates :user, presence: true

		has_many :interact_interact_categories, dependent: :destroy
  	has_many :interaction_categories, through: :interact_interact_categories

 	 	has_many :interaction_emotional_reactions, dependent: :destroy
  	has_many :emotional_reactions, through: :interaction_emotional_reactions

	 	def contact_full_name
	    "#{contact.first_name} #{contact.last_name}" if contact.present?
	  end

end
