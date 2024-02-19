class ContactCategory < ApplicationRecord

	validates :name, presence: true

	belongs_to :category
	belongs_to :contact

end
