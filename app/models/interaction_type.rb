class InteractionType < ApplicationRecord

	has_many :interactions, dependent: :nullify
	
end
