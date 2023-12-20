class InteractionCategory < ApplicationRecord

	has_many :contact_categories, dependent: :destroy
	has_many :contacts, through: :contact_categories

	has_many :interact_interact_categories, dependent: :destroy
	has_many :interactions, through: :interact_interact_categories	

end
