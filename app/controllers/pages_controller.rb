class PagesController < ApplicationController

	def index
	end

	def home
		@contacts = current_user.contacts.limit(5)

		@recently_added_contacts = current_user.contacts
																					.where(category_id: 1)
																					.order(created_at: :desc)
																					.limit(5)

		@next_to_contact = @contacts

		@going_up = @contacts

		@going_down = @contacts

		contacts_with_zero_points = current_user.contacts.select do |contact|
		  contact.total_points == 0
		end

		@at_zero = contacts_with_zero_points.shuffle.take(5)


		@holding_steady = @contacts

		@needs_attention = @contacts		

		@true_best_friends = @contacts

		@best_friends = @contacts

		@friends = @contacts

		@acquaintances = @contacts

		@close_to_zero = @contacts

		@when_sad_call = @contacts

		@limit_your_time_with = @contacts

		@hang_out_more_with = @contacts

		@your_future_is = @contacts

		@friendliest_places = current_user.locations.limit(5)

		@happiest_locations = current_user.locations.limit(5)

		@avoid_or_fix_locations = current_user.locations.limit(5)

		@huge_let_downs = @contacts

		@takers_and_leeches = @contacts

		
	end
	
end
