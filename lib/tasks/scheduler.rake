namespace :scheduler do
  desc 'The following are all run by the scheduler on heroku'

  #test in command line with: rake scheduler:point_leech
  task point_leech: :environment do
    Contact.where('points > 0').each do |contact|
      contact.leech_points
    end
  end
end
