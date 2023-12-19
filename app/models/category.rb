class Category < ApplicationRecord

		belongs_to :user

  	has_many :contact_categories, dependent: :destroy
  	has_many :contacts, through: :contact_categories

end
