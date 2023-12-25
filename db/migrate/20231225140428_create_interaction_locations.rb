class CreateInteractionLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :interaction_locations do |t|  

      t.references :interaction, foreign_key: true
      t.references :location, foreign_key: true

      t.timestamps
    end
  end
end
