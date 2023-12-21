class AddColumnsToPoints < ActiveRecord::Migration[7.0]
  def change
    add_reference :points, :contact, foreign_key: true
    add_reference :points, :interaction, foreign_key: true
    add_column :points, :interaction_type_points, :integer
    add_column :points, :interaction_length_points, :integer
    add_column :points, :emotional_reactions_points, :integer
    add_column :points, :who_initiated_contact_points, :integer
  end
end
