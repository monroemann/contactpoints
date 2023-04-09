class AddUserReferenceToContacts < ActiveRecord::Migration[7.0]
  def change
    change_table :contacts do |t|
      t.references :user
    end
  end
end
