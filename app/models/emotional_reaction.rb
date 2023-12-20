class EmotionalReaction < ApplicationRecord

	has_many :interaction_emotional_reactions, dependent: :destroy
  has_many :interactions, through: :interaction_emotional_reactions

end
