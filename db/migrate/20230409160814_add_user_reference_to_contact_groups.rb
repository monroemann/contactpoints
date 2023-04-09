class AddUserReferenceToContactGroups < ActiveRecord::Migration[7.0]
  def change
    change_table :contact_groups do |t|
      t.references :user
    end
  end
end
