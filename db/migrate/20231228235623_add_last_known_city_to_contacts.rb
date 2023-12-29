class AddLastKnownCityToContacts < ActiveRecord::Migration[7.0]
  def change
    add_reference :contacts, :last_known_city, null: true, foreign_key: true
  end
end
