class CreateLastKnownCountries < ActiveRecord::Migration[7.0]
  def change
    create_table :last_known_countries do |t|
      t.string :name

      t.timestamps
    end
  end
end
