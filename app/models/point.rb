class Point < ApplicationRecord

	belongs_to :contact
  belongs_to :interaction

   def total_points
    interaction_type_points.to_i + 
    interaction_length_points.to_i + 
    emotional_reactions_points.to_i + 
    who_initiated_contact_points.to_i
  end

end
