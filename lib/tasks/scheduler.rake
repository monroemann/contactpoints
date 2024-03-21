namespace :scheduler do
    desc 'The following are all run by the scheduler on heroku'

    task point_leech: :environment do
        contacts = Contact.all
        contacts.each do |contact|
            contact.[remove_one_point]
        end
    end

end