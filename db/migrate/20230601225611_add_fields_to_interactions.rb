class AddFieldsToInteractions < ActiveRecord::Migration[7.0]
  def change
    add_reference :interactions, :contact, foreign_key: true
    add_reference :interactions, :interaction_type, foreign_key: true
    add_column :interactions, :date, :datetime
    add_column :interactions, :length, :text
    add_column :interactions, :location, :text
    add_column :interactions, :i_initiated, :boolean, default: false
  end
end
