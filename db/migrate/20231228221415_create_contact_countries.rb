class CreateContactCountries < ActiveRecord::Migration[7.0]
  def change
    create_table :contact_countries do |t|

      t.references :contact, foreign_key: true
      t.references :last_known_country, foreign_key: true

      t.timestamps
    end
  end
end
