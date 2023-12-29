class LastKnownCity < ApplicationRecord

  has_many :contact_cities, dependent: :destroy
  has_many :contacts, through: :contact_cities

end
