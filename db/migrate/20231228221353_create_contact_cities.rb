class CreateContactCities < ActiveRecord::Migration[7.0]
  def change
    create_table :contact_cities do |t|

      t.references :contact, foreign_key: true
      t.references :last_known_city, foreign_key: true

      t.timestamps
    end
  end
end
