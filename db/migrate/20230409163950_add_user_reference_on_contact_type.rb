class AddUserReferenceOnContactType < ActiveRecord::Migration[7.0]
  def change
    change_table :contact_types do |t|
      t.references :user
    end
  end
end
