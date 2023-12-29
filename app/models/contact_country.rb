class ContactCountry < ApplicationRecord

  belongs_to :contact
  belongs_to :last_known_country
  
end
