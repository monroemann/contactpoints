class ContactGroup < ApplicationRecord

	belongs_to :user
	
	has_many :contact_groupings, dependent: :destroy
	has_many :contacts, through: :contact_groupings

end
