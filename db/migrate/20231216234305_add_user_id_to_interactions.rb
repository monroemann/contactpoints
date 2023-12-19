class AddUserIdToInteractions < ActiveRecord::Migration[7.0]
  def change
    add_column :interactions, :user_id, :integer
  end
end
