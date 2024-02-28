class AddUserIdToLastKnownCountries < ActiveRecord::Migration[7.0]
  def change
    add_reference :last_known_countries, :user, foreign_key: true, null: true
  end
end
