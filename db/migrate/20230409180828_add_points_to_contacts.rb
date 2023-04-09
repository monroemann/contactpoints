class AddPointsToContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :contacts, :points, :integer, default: 0
  end
end
