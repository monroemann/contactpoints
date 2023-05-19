class Contact < ApplicationRecord

	belongs_to :user

	has_many :contact_groupings, dependent: :destroy
	has_many :contact_groups, through: :contact_groupings

	has_many :contact_typings, dependent: :destroy
	has_many :contact_types, through: :contact_typings

end
