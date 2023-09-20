class SearchController < ApplicationController

	def index
		results = search_for_contacts

		respond_to do |format|
			format.turbo_stream do
				render turbo_stream: 
					turbo_stream.update('contacts',
															partial: 'contacts/contacts',
															locals: {contacts: @raults})

			end
		end
	end

	def suggestions
		results = search_for_contacts

		respond_to do |format|
			format.turbo_stream do
				render turbo_stream: 
					turbo_stream.update('suggestions',
															partial: 'search/suggestions',
															locals: {contacts: @raults})

			end
		end
	end

	private

	def search_for_contacts
		if params [:query].blank?
			Contact.all?
		else
			Contact.search(params[:query], 
				fields: %i[first_name, last_name, last_known_city, last_known_country],
				operator: 'or',
				match: :text_middle)
		end
	end

end
