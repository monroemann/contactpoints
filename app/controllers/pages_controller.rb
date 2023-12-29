class PagesController < ApplicationController

	def index
	end

	def home
		@contacts = current_user.contacts.limit(5)

		# DONE
		@recently_added_contacts = current_user.contacts
																					.order(created_at: :desc)

		# FIX
		@next_to_contact = @contacts

		# FIX OR REMOVE
		@going_up = @contacts

		# FIX OR REMOVE
		@going_down = current_user.contacts.map { |contact| 
			points_going_down?(contact) }.flatten.uniq

		# DONE (though perhaps best to redo this query using 'points' from contact.rb)
		# AT ZERO POINTS
		contacts_with_zero_points = current_user.contacts.select do |contact|
		  contact.total_points == 0
		end
		@at_zero = contacts_with_zero_points.shuffle.take(5)

		# FIX OR REMOVE
		@holding_steady = @contacts

		# Fix or remove.  Perhaps not necessary.
		# All those whose points have been below 25 for more than six months
		@needs_attention = current_user.contacts
		 
		# TRUE BEST FRIENDS
		# All those whose points are above 200, who you've known for more than two years, 
		# and who have reached out to you within the last 2 years at least 5 times 
		# [in a social manner] and who gives you 90% or more positive than negative emotions

		# NEED TO ADD: And... who you've interacted with in any way over the last three months
		@true_best_friends = current_user.contacts
		  .joins(:interactions)
		  .joins("JOIN interaction_emotional_reactions ON interaction_emotional_reactions.interaction_id = interactions.id")
		  .joins("JOIN emotional_reactions ON emotional_reactions.id = interaction_emotional_reactions.emotional_reaction_id")
		  .where("contacts.points > ?", 200)
		  .where("contacts.date_first_met <= ?", 2.years.ago)
		  .where("interactions.date >= ?", 2.years.ago)
		  .group("contacts.id")
		  .having("COUNT(CASE WHEN emotional_reactions.name = 'positive' THEN 1 ELSE NULL END) >= 0.9 * COUNT(CASE WHEN emotional_reactions.name = 'negative' THEN 1 ELSE NULL END)")
		  .having("COUNT(CASE WHEN interactions.you_initiated_contact = false THEN 1 ELSE NULL END) >= 5")

  	@true_best_friends_count = @true_best_friends.count

		  puts "@true_best_friends: #{@true_best_friends.inspect}"
		  puts "@true_best_friends_count: #{@true_best_friends_count.inspect}"

		# BEST FRIENDS
		# All those whose points are above 100, who you've known for more than one year, 
		# who have reached out to you within the last year at least 3 times [in a social manner], 
		# and who gives you at least 80% or more positive than negative emotions

		# NEED TO ADD: And... who you've interacted with in any way over the last six months
		@best_friends = current_user.contacts
		  .joins(:interactions)
		  .joins("JOIN interaction_emotional_reactions ON interaction_emotional_reactions.interaction_id = interactions.id")
		  .joins("JOIN emotional_reactions ON emotional_reactions.id = interaction_emotional_reactions.emotional_reaction_id")
		  .where("contacts.points > ?", 100)
		  .where("contacts.date_first_met <= ?", 1.year.ago)
		  .where("interactions.date >= ?", 1.year.ago)
		  .group("contacts.id")
		  .having("COUNT(CASE WHEN emotional_reactions.name = 'positive' THEN 1 ELSE NULL END) >= 0.8 * COUNT(CASE WHEN emotional_reactions.name = 'negative' THEN 1 ELSE NULL END)")
		  .having("COUNT(CASE WHEN interactions.you_initiated_contact = false THEN 1 ELSE NULL END) >= 3")
		  .where.not(id: @true_best_friends)
		  .where.not(id: @best_friends)
		  .where.not(id: @acquaintances)
		  .distinct

		@best_friends_count = @best_friends.count

			puts @best_friends.to_sql
			 
		# FRIENDS
		# All those whose points are above 50, who you've known for more than six months, who has 
		# reached out to you within the last six months at least once [in a social manner], and 
		# who gives you at least 70% or more positive than negative emotions

		# NEED TO ADD: And... who you've interacted with in any way over the last nine months
		# Maybe just change the interaction.date query to 2 years here, 1 year above, 6 months 
		# for TBFs.  That may work.
		@friends = current_user.contacts
		  .joins(:interactions)
		  .joins("JOIN interaction_emotional_reactions ON interaction_emotional_reactions.interaction_id = interactions.id")
		  .joins("JOIN emotional_reactions ON emotional_reactions.id = interaction_emotional_reactions.emotional_reaction_id")
		  .where("contacts.points > ?", 50)
		  .where("contacts.date_first_met <= ?", 6.months.ago)
		  .where("interactions.date >= ?", 6.months.ago)
		  .group("contacts.id")
		  .having("COUNT(CASE WHEN emotional_reactions.name = 'positive' THEN 1 ELSE NULL END) >= 0.7 * COUNT(CASE WHEN emotional_reactions.name = 'negative' THEN 1 ELSE NULL END)")
		  .having("COUNT(CASE WHEN interactions.you_initiated_contact = false THEN 1 ELSE NULL END) >= 1")
		  .where.not(id: @true_best_friends)
		  .where.not(id: @best_friends)
		  .where.not(id: @acquaintances)
		  .distinct

		@friends_count = @friends.count

		# ACQUAINTANCES
		# All those whose points are above 25, who you've known for more than three months, 
		# and with whom you've interacted at least once [in a social manner] in the last 3 months, 
		# and who gives you at least 60% or more positive than negative emotions

		# Again: Change it to interacted at least once in a social manner in the last 3 years
		@acquaintances = current_user.contacts
		  .joins(:interactions)
		  .joins("JOIN interaction_emotional_reactions ON interaction_emotional_reactions.interaction_id = interactions.id")
		  .joins("JOIN emotional_reactions ON emotional_reactions.id = interaction_emotional_reactions.emotional_reaction_id")
		  .where("contacts.points > ?", 25)
		  .where("contacts.date_first_met <= ?", 3.months.ago)
		  .where("interactions.date >= ?", 3.months.ago)
		  .group("contacts.id")
		  .having("COUNT(CASE WHEN emotional_reactions.name = 'positive' THEN 1 ELSE NULL END) >= 0.6 * 
		  	COUNT(CASE WHEN emotional_reactions.name = 'negative' THEN 1 ELSE NULL END)")
		  .where.not(id: @true_best_friends)
		  .where.not(id: @best_friends)
		  .where.not(id: @friends)
		  .distinct

	
		@acquaintances_count = @acquaintances.count

		# All those [whose points that have been going down over the last year], and have 25 points 
		# or less
		@close_to_zero = current_user.contacts
		  .where("contacts.points < ? AND contacts.points > ?", 25, 0)

		@close_to_zero_count = @close_to_zero.count

		# All those who are at least a friend, who over the last year has consistently listened to you,
		# cheered you up, or solved problems for you, and do not have more than 30% negative emotions
		# in the previous 1-year period.
		@when_sad_call = current_user.contacts
		  .joins(:interactions)
		  .joins("JOIN interaction_emotional_reactions ON interaction_emotional_reactions.interaction_id = interactions.id")
		  .joins("JOIN emotional_reactions ON emotional_reactions.id = interaction_emotional_reactions.emotional_reaction_id")
		  .where("contacts.points > ?", 50)
		  .where("contacts.date_first_met <= ?", 1.year.ago)
		  .where("interactions.date >= ?", 1.year.ago)
		  .group("contacts.id")
		  .having("COUNT(CASE WHEN emotional_reactions.name IN ('Listened To', 'Cheered Up', 'Problems Solved') THEN 1 ELSE NULL END) >= 0.5 * COUNT(CASE WHEN emotional_reactions.name = 'positive' THEN 1 ELSE NULL END)")
		  .having("COUNT(CASE WHEN emotional_reactions.name = 'negative' THEN 1 ELSE NULL END) <= 0.3 * COUNT(*)")
		  .distinct

		@when_sad_call_count = @when_sad_call.count

		# All those with at least 10 points who leave you with 60% or more negative emotions.
		@limit_your_time_with = current_user.contacts
		  .joins(:interactions)
		  .joins("JOIN interaction_emotional_reactions ON interaction_emotional_reactions.interaction_id = interactions.id")
		  .joins("JOIN emotional_reactions ON emotional_reactions.id = interaction_emotional_reactions.emotional_reaction_id")
		  .where("contacts.points > ?", 10)
		  .group("contacts.id")
		  .having("COUNT(CASE WHEN emotional_reactions.name = 'negative' THEN 1 ELSE NULL END) / COUNT(*) >= 0.6")
		  .having("COUNT(*) >= 3")

		@limit_your_time_with_count = @limit_your_time_with.count


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

		# Add
		# @fairweather_friends = 
		
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
