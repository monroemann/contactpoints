class ContactCity < ApplicationRecord

  belongs_to :contact
  belongs_to :last_known_city

end
