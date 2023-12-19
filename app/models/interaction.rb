class Interaction < ApplicationRecord

		belongs_to :user
		belongs_to :contact

		validates :user, presence: true

 	def contact_full_name
    "#{contact.first_name} #{contact.last_name}" if contact.present?
  end

end
