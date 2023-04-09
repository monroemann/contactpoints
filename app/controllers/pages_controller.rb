class PagesController < ApplicationController

	def index
	end

	def home
		@recently_added_contacts = current_user.contacts.order(:created_at)
	end
	
end
