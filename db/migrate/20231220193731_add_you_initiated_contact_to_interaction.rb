class AddYouInitiatedContactToInteraction < ActiveRecord::Migration[7.0]
  def change
    add_column :interactions, :you_initiated_contact, :boolean, default: true
  end
end
