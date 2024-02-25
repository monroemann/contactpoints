# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "**Creating Emotional Reactions**"
EmotionalReaction.create([
  {name: "Appreciated", description: "Made you feel appreciated"},
  {name: "Calm", description: "Made you feel calm"},
  {name: "Cheered Up", description: "Made you feel cheered up"},
  {name: "Creative", description: "Made you feel creative"},
  {name: "Energized", description: "Made you feel energized"},
  {name: "Excited", description: "Made you feel excited"},
  {name: "Grateful", description: "Made you feel grateful"},
  {name: "Happy", description: "Made you feel happy"},
  {name: "Inspired", description: "Made you feel inspired"},
  {name: "Intellectual", description: "Made you feel intellectual"},
  {name: "Joyful", description: "Made you feel joyful"},
  {name: "Laughing", description: "Made you laugh"},
  {name: "Listened To", description: "Made you feel listened to"},
  {name: "Loved", description: "Made you feel loved"},
  {name: "Motivated", description: "Made you feel motivated"},
  {name: "Optimistic", description: "Made you feel optimistic"},
  {name: "Problems Solved", description: "Made you feel like problems were solved"},
  {name: "Smart", description: "Made you feel smart"},
  {name: "Smiling", description: "Made you smile"},
  {name: "Special", description: "Made you feel special"},
  {name: "Trusting", description: "Made you feel trusting"},
  {name: "Valued", description: "Made you feel valued"},
  {name: "Like a Winner", description: "Made you feel like a winner"},
  
  {name: "Abandoned", description: "Made you feel abandoned"},
  {name: "Anxious", description: "Made you feel anxious"},
  {name: "Bitter", description: "Made you feel bitter"},
  {name: "Confused", description: "Made you feel confused"},
  {name: "Depressed", description: "Made you feel depressed"},
  {name: "Desperate", description: "Made you feel desperate"},
  {name: "Disappointed", description: "Made you feel disappointed"},
  {name: "Empty", description: "Made you feel empty"},
  {name: "Frustrated", description: "Made you feel frustrated"},
  {name: "Hopeless", description: "Made you feel hopeless"},
  {name: "Let Down", description: "Made you feel let down"},
  {name: "Like a Loser", description: "Made you feel like a loser"},
  {name: "Needy", description: "Made you feel needy"},
  {name: "Overwhelmed", description: "Made you feel overwhelmed"},
  {name: "Pessimistic", description: "Made you feel pessimistic"},
  {name: "Problems Created", description: "Made you feel like problems were created"},
  {name: "Sad", description: "Made you feel sad"},
  {name: "Scared", description: "Made you feel scared"},
  {name: "Smothered", description: "Made you feel smothered"},
  {name: "Stressed", description: "Made you feel stressed"},
  {name: "Tired", description: "Made you feel tired"},
  {name: "Used", description: "Made you feel used"}
])

puts "**Creating Interaction Categories**"
InteractionCategory.create([
	{name: "Social/Personal", description: "You both are happy to be in the other's company, or are trying! Not related to business."},
  {name: "Business/Career/Work", description: "You work together either at a job, as a vendor, in a business, etc. and have a measure of a relationship."},
  {name: "Transactional", description: "You or the other person is getting something transactional out of the meeting/contact, and it is really nothing more."}
])
