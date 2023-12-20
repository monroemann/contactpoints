class PagesController < ApplicationController

	def index
	end

	def home
		@recently_added_contacts = current_user.contacts
																					.where(category_id: 1)
																					.order(:created_at)
																					.limit(5)
		@contacts = current_user.contacts.limit(5)
	end
	
end
