class EmotionalReaction < ApplicationRecord

	validates :name, presence: true

	has_many :interaction_emotional_reactions, dependent: :destroy
  has_many :interactions, through: :interaction_emotional_reactions

end
