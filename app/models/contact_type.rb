class ContactType < ApplicationRecord

	validates :name, presence: true

	belongs_to :user
	
	has_many :contact_typings, dependent: :destroy
	has_many :contacts, through: :contact_typings


end
