class LastKnownCountry < ApplicationRecord

  has_many :contact_countries, dependent: :destroy
  has_many :contacts, through: :contact_countries

end
