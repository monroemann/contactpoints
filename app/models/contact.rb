class Contact < ApplicationRecord

	belongs_to :user

	has_many :contact_groups
	has_many :contact_types

end
