class AddPointsToInteractionType < ActiveRecord::Migration[7.0]
  def change
    add_column :interaction_types, :point_value, :integer
  end
end
