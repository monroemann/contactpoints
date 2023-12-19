class AddCategoryIdToContacts < ActiveRecord::Migration[7.0]
  def change
    add_reference :contacts, :category, null: false, foreign_key: true, default: 1
  end
end
