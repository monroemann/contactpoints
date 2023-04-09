class PagesController < ApplicationController

	def index
	end

	def home
		@recently_added_contacts = Contact.all.order(:created_at)
	end
	
end
