class AddLocationIdToInteractions < ActiveRecord::Migration[7.0]
  def change
    add_column :interactions, :location_id, :bigint
  end
end
