class PagesController < ApplicationController

	def index
	end

	# When you change the queries here, they may need to also be changed in home method too
	def all_points

		@contacts = current_user.contacts

		# DONE
		@recently_added_contacts = current_user.contacts
																					.order(created_at: :desc)

		# FIX
		@next_to_contact = @contacts.shuffle.take(30)

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
		@at_zero = contacts_with_zero_points.shuffle.take(30)

		# FIX OR REMOVE
		@holding_steady = @contacts

		# Fix or remove.  Perhaps not necessary.
		# All those whose points have been below 25 for more than six months
		# Or keep this, but get rid of 'close to zero'
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

		# All those with at least 10 points and at least 3 interactions who leave you with 
		# 60% or more negative emotions.
		@limit_your_time_with = current_user.contacts
		  .joins(:interactions)
		  .joins("JOIN interaction_emotional_reactions ON interaction_emotional_reactions.interaction_id = interactions.id")
		  .joins("JOIN emotional_reactions ON emotional_reactions.id = interaction_emotional_reactions.emotional_reaction_id")
		  .where("contacts.points > ?", 10)
		  .group("contacts.id")
		  .having("COUNT(CASE WHEN emotional_reactions.name = 'negative' THEN 1 ELSE NULL END) / COUNT(*) >= 0.6")
		  .having("COUNT(*) >= 3")

		@limit_your_time_with_count = @limit_your_time_with.count


		# All those with at least 10 points and at least 3 interactions who leave you with 
		# 80% or more positive emotions
		@hang_out_more_with = current_user.contacts
		  .joins(:interactions)
		  .joins("JOIN interaction_emotional_reactions ON interaction_emotional_reactions.interaction_id = interactions.id")
		  .joins("JOIN emotional_reactions ON emotional_reactions.id = interaction_emotional_reactions.emotional_reaction_id")
		  .where("contacts.points > ?", 10)
		  .group("contacts.id")
		  .having("COUNT(CASE WHEN emotional_reactions.name = 'positive' THEN 1 ELSE NULL END) / COUNT(*) >= 0.8")
		  .having("COUNT(*) > 3")


		@hang_out_more_with_count = @hang_out_more_with.count

		# FIX
		# Get the interactions within the last 3 months for the current_user
		# Assuming the models are named User, Contact, and Interaction
		recent_contacts = current_user.contacts.joins(:interactions).where('interactions.created_at >= ?', 3.months.ago).distinct

		# Calculate total points for each contact
		contact_points = recent_contacts.map do |contact|
		  total_points = contact.interactions.where('interactions.created_at >= ?', 3.months.ago).sum { |interaction| interaction.calculate_points_for_interaction_length }
		  [contact, total_points]
		end

		# Sort contacts by points in descending order
		sorted_contacts = contact_points.sort_by { |contact, points| -points }

		# Fetch the contacts with the most points
		@your_future_is = sorted_contacts.map(&:first)


 		@your_future_is_count = @your_future_is.count

		# FRIENDLIEST PLACES
		# Where you have the most TBFs, BFs, and Fs

		# Count interactions for each contact category (true_best_friends, best_friends, friends)
		true_best_friends_counts = Interaction.joins(:contact)
		  .where(contacts: { id: @true_best_friends })
		  .group("interactions.location_id")
		  .count

		best_friends_counts = Interaction.joins(:contact)
		  .where(contacts: { id: @best_friends })
		  .group("interactions.location_id")
		  .count

		friends_counts = Interaction.joins(:contact)
		  .where(contacts: { id: @friends })
		  .group("interactions.location_id")
		  .count

		# Combine the counts for all categories
		all_counts = true_best_friends_counts.merge(best_friends_counts) { |_, true_best, best| true_best + best }
		                                  .merge(friends_counts) { |_, all_counts, friends| all_counts + friends }

		# Find the location ids with the highest counts
		max_counts = all_counts.values.max(30) # Get the top 30 highest counts
		top_location_ids = all_counts.select { |_, count| max_counts.include?(count) }.keys

		# Retrieve the locations with the highest counts
		@friendliest_places = Location.where(id: top_location_ids)

		@friendliest_places_count = @friendliest_places.count

		# HAPPIEST LOCATIONS
		# Where your emotions are 70% or more positive
		@happiest_locations = current_user.locations
		  .joins(interactions: [:emotional_reactions])
		  .where("interactions.user_id = ?", current_user.id)
		  .group("locations.id")
		  .order(
		    Arel.sql("SUM(CASE WHEN emotional_reactions.name = 'positive' THEN 1 ELSE 0 END) DESC"),
		    Arel.sql("locations.name DESC")  # Ensure both criteria are ordered in descending order
		  )
		  .first(30)


		@happiest_locations_count = @happiest_locations.count

		# FIX
		@avoid_or_fix_locations = current_user.locations.limit(30)

		# All those who: Had their first meeting more than 3 months ago; had interactions within 
		# the last 10 years, at least 10% of the total interactions for each contact have emotional 
		# reactions with names 'Let Down' or 'Abandoned', and has had at least 3 interactions.
		@huge_let_downs = current_user.contacts
  .joins(:interactions)
  .joins("JOIN interaction_emotional_reactions ON interaction_emotional_reactions.interaction_id = interactions.id")
  .joins("JOIN emotional_reactions ON emotional_reactions.id = interaction_emotional_reactions.emotional_reaction_id")
  .where("contacts.date_first_met <= ?", 3.months.ago)
  .where("interactions.date >= ?", 10.years.ago)
  .group("contacts.id")
  .having("SUM(CASE WHEN emotional_reactions.name IN ('Let Down', 'Abandoned', 'Disappointed') THEN 1 ELSE 0 END) >= 0.1 * COUNT(*)")  # At least 10% of total interactions are 'Let Down' or 'Abandoned'
  .having("COUNT(*) >= 3")
  .distinct

		@huge_let_downs_count = @huge_let_downs.count

		
		# TAKERS AND LEECHES
		# People who take from you and don't show gratitude
		# All those who: Had their first meeting more than 3 months ago; had interactions within 
		# the last 10 years, at least 10% of the total interactions for each contact have emotional 
		# reactions with names 'Let Down' or 'Abandoned', and has had at least 3 interactions.
		@takers_and_leeches = current_user.contacts
  .joins(:interactions)
  .joins("JOIN interaction_emotional_reactions ON interaction_emotional_reactions.interaction_id = interactions.id")
  .joins("JOIN emotional_reactions ON emotional_reactions.id = interaction_emotional_reactions.emotional_reaction_id")
  .where("contacts.date_first_met <= ?", 3.months.ago)
  .where("interactions.date >= ?", 10.years.ago)
  .group("contacts.id")
  .having("SUM(CASE WHEN emotional_reactions.name IN ('Angry', 'Emotionally Tired', 'Depleted', 
  'Empty', 'Bitter', 'Used', '') THEN 1 ELSE 0 END) >= 0.1 * COUNT(*)")  # At least 10% of total interactions include these
  .having("COUNT(*) >= 3")
  .distinct



		@takers_and_leeches_count = @takers_and_leeches.count

		# Add
		# @fairweather_friends = 


	end


	# HOME ACTION
	# When you change the queries here, they may need to also be changed in all_points method too
	def home
		@contacts = current_user.contacts

		# DONE
		@recently_added_contacts = current_user.contacts
																					.order(created_at: :desc)

		# FIX
		@next_to_contact = @contacts.shuffle.take(5)

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

		# All those who have 25 points or less
		@needs_attention = current_user.contacts
		  .where("contacts.points < ? AND contacts.points > ?", 25, 0)

		@needs_attention_count = @needs_attention.count
		 
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


		# WHEN SAD CALL
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

		# LIMIT YOUR TIME WITH
		# All those with at least 10 points and at least 3 interactions who leave you with 
		# 60% or more negative emotions.
		@limit_your_time_with = current_user.contacts
		  .joins(:interactions)
		  .joins("JOIN interaction_emotional_reactions ON interaction_emotional_reactions.interaction_id = interactions.id")
		  .joins("JOIN emotional_reactions ON emotional_reactions.id = interaction_emotional_reactions.emotional_reaction_id")
		  .where("contacts.points > ?", 10)
		  .group("contacts.id")
		  .having("COUNT(CASE WHEN emotional_reactions.name = 'negative' THEN 1 ELSE NULL END) / COUNT(*) >= 0.6")
		  .having("COUNT(*) >= 3")

		@limit_your_time_with_count = @limit_your_time_with.count

		# HANG OUT MORE WITH
		# All those with at least 10 points and at least 3 interactions who leave you with 
		# 80% or more positive emotions
		@hang_out_more_with = current_user.contacts
		  .joins(:interactions)
		  .joins("JOIN interaction_emotional_reactions ON interaction_emotional_reactions.interaction_id = interactions.id")
		  .joins("JOIN emotional_reactions ON emotional_reactions.id = interaction_emotional_reactions.emotional_reaction_id")
		  .where("contacts.points > ?", 10)
		  .group("contacts.id")
		  .having("COUNT(CASE WHEN emotional_reactions.name = 'positive' THEN 1 ELSE NULL END) / COUNT(*) >= 0.8")
		  .having("COUNT(*) > 3")


		@hang_out_more_with_count = @hang_out_more_with.count

		# YOUR FUTURE IS
		# FIX
		# Should show contacts you have spent the most total time with over the last 3 months

		# Get the interactions within the last 3 months for the current_user
		# Assuming the models are named User, Contact, and Interaction
		recent_contacts = current_user.contacts.joins(:interactions).where('interactions.created_at >= ?', 3.months.ago).distinct

		# Calculate total points for each contact
		contact_points = recent_contacts.map do |contact|
		  total_points = contact.interactions.where('interactions.created_at >= ?', 3.months.ago).sum { |interaction| interaction.calculate_points_for_interaction_length }
		  [contact, total_points]
		end

		# Sort contacts by points in descending order
		sorted_contacts = contact_points.sort_by { |contact, points| -points }

		# Fetch the contacts with the most points
		@your_future_is = sorted_contacts.map(&:first)


 		@your_future_is_count = @your_future_is.count

		# FRIENDLIEST PLACES
		# Where you have the most TBFs, BFs, and Fs

		# Count interactions for each contact category (true_best_friends, best_friends, friends)
		true_best_friends_counts = Interaction.joins(:contact)
		  .where(contacts: { id: @true_best_friends })
		  .group("interactions.location_id")
		  .count

		best_friends_counts = Interaction.joins(:contact)
		  .where(contacts: { id: @best_friends })
		  .group("interactions.location_id")
		  .count

		friends_counts = Interaction.joins(:contact)
		  .where(contacts: { id: @friends })
		  .group("interactions.location_id")
		  .count

		# Combine the counts for all categories
		all_counts = true_best_friends_counts.merge(best_friends_counts) { |_, true_best, best| true_best + best }
		                                  .merge(friends_counts) { |_, all_counts, friends| all_counts + friends }

		# Find the location ids with the highest counts
		max_counts = all_counts.values.max(30) # Get the top 30 highest counts
		top_location_ids = all_counts.select { |_, count| max_counts.include?(count) }.keys

		# Retrieve the locations with the highest counts
		@friendliest_places = Location.where(id: top_location_ids)

		@friendliest_places_count = @friendliest_places.count

		# HAPPIEST LOCATIONS
		# Where your emotions are 70% or more positive
		@happiest_locations = current_user.locations
		  .joins(interactions: [:emotional_reactions])
		  .where("interactions.user_id = ?", current_user.id)
		  .group("locations.id")
		  .order(
		    Arel.sql("SUM(CASE WHEN emotional_reactions.name = 'positive' THEN 1 ELSE 0 END) DESC"),
		    Arel.sql("locations.name DESC")  # Ensure both criteria are ordered in descending order
		  )
		  .first(30)


		@happiest_locations_count = @happiest_locations.count

		# FIX
		@avoid_or_fix_locations = current_user.locations.limit(5)

		# HUGE LET DOWNS
		# All those who: Had their first meeting more than 3 months ago; had interactions within 
		# the last 10 years, at least 10% of the total interactions for each contact have emotional 
		# reactions with names 'Let Down' or 'Abandoned', and has had at least 3 interactions.
		@huge_let_downs = current_user.contacts
  .joins(:interactions)
  .joins("JOIN interaction_emotional_reactions ON interaction_emotional_reactions.interaction_id = interactions.id")
  .joins("JOIN emotional_reactions ON emotional_reactions.id = interaction_emotional_reactions.emotional_reaction_id")
  .where("contacts.date_first_met <= ?", 3.months.ago)
  .where("interactions.date >= ?", 10.years.ago)
  .group("contacts.id")
  .having("SUM(CASE WHEN emotional_reactions.name IN ('Let Down', 'Abandoned', 'Disappointed') THEN 1 ELSE 0 END) >= 0.1 * COUNT(*)")  # At least 10% of total interactions are 'Let Down' or 'Abandoned'
  .having("COUNT(*) >= 3")
  .distinct

		@huge_let_downs_count = @huge_let_downs.count

		
		# TAKERS AND LEECHES
		# People who take from you and don't show gratitude
		# All those who: Had their first meeting more than 3 months ago; had interactions within 
		# the last 10 years, at least 10% of the total interactions for each contact have emotional 
		# reactions with names 'Let Down' or 'Abandoned', and has had at least 3 interactions.
		@takers_and_leeches = current_user.contacts
  .joins(:interactions)
  .joins("JOIN interaction_emotional_reactions ON interaction_emotional_reactions.interaction_id = interactions.id")
  .joins("JOIN emotional_reactions ON emotional_reactions.id = interaction_emotional_reactions.emotional_reaction_id")
  .where("contacts.date_first_met <= ?", 3.months.ago)
  .where("interactions.date >= ?", 10.years.ago)
  .group("contacts.id")
  .having("SUM(CASE WHEN emotional_reactions.name IN ('Angry', 'Emotionally Tired', 'Depleted', 
  'Empty', 'Bitter', 'Used', '') THEN 1 ELSE 0 END) >= 0.1 * COUNT(*)")  # At least 10% of total interactions include these
  .having("COUNT(*) >= 3")
  .distinct



		@takers_and_leeches_count = @takers_and_leeches.count

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
