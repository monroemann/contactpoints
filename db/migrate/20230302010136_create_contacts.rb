class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :last_known_country
      t.string :last_known_city
      t.string :mobile_phone_1
      t.string :mobile_phone_2
      t.string :office_phone_1
      t.string :office_phone_2
      t.string :home_phone
      t.string :other_phone
      t.string :email_1
      t.string :email_2
      t.string :email_3
      t.string :email_4
      t.string :email_5
      t.string :website_1
      t.string :website_2
      t.string :website_3
      t.string :website_4
      t.string :website_5
      t.string :website_6
      t.string :website_7
      t.string :website_8
      t.string :contact_apps
      t.string :birthday
      t.text :address_1
      t.text :address_2
      t.text :how_we_met
      t.string :things_I_like
      t.text :best_memories
      t.string :areas_for_improvement
      t.string :notes

      t.timestamps
    end
  end
end
