class PagesController < ApplicationController

	def index
	end

	def home
		@contacts = current_user.contacts.limit(5)

		# DONE
		@recently_added_contacts = current_user.contacts
																					.order(created_at: :desc)
																					.limit(5)
		# FIX
		@next_to_contact = @contacts

		# FIX
		@going_up = @contacts

		# FIX
		@going_down = current_user.contacts.map { |contact| 
			points_going_down?(contact) }.flatten.uniq

		# DONE (though perhaps best to redo this query using 'points' from contact.rb)
		contacts_with_zero_points = current_user.contacts.select do |contact|
		  contact.total_points == 0
		end
		@at_zero = contacts_with_zero_points.shuffle.take(5)

		# FIX
		@holding_steady = @contacts

		# FIX
		@needs_attention = @contacts		

		# FIX
		@true_best_friends = @contacts

		# FIX
		@best_friends = @contacts

		# FIX
		@friends = @contacts

		# FIX
		@acquaintances = @contacts

		# FIX
		@close_to_zero = @contacts

		# FIX
		@when_sad_call = @contacts

		# FIX
		@limit_your_time_with = @contacts

		# FIX
		@hang_out_more_with = @contacts

		# FIX
		@your_future_is = @contacts

		# FIX
		@friendliest_places = current_user.locations.limit(5)

		# FIX
		@happiest_locations = current_user.locations.limit(5)

		# FIX
		@avoid_or_fix_locations = current_user.locations.limit(5)

		# FIX
		@huge_let_downs = @contacts

		# FIX
		@takers_and_leeches = @contacts
		
	end

	private

	# There is an issue in the method below.  It should consider not the date the contact 
	# was created, but instead the date of all interactions over that period.  Otherwise, 
	# I will create a new interaction and backdate it 2 months ago, but since I only 
	# created the contact last week, this method is not going to be accurate.  
	# Maybe it's okay for now, but it needs to be changed.  It also needs to be tested.

  def points_going_down?(contact)
    # Retrieve the points for the current contact and the contact from a month ago
    current_points = contact.points&.last
    points_one_month_ago = contact.points&.where("created_at <= ?", 1.month.ago).first

    # Check if points have been going down, considering the case where one contact has no data from one month ago
    return nil unless current_points && points_one_month_ago

    # Check if points have been going down
    current_points < points_one_month_ago
  end
	
end
