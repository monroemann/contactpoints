class PagesController < ApplicationController

	def index
	end

	def home
		@recently_added_contacts = current_user.contacts.where(category_id: 4).order(:created_at)
		@contacts = current_user.contacts
	end
	
end
