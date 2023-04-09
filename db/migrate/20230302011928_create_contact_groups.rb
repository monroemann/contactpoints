class CreateContactGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :contact_groups do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
