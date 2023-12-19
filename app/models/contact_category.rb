class ContactCategory < ApplicationRecord

	belongs_to :category
	belongs_to :contact

end
