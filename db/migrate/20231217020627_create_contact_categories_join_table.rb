class CreateContactCategoriesJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_table :contact_categories do |t|

      t.references :contact
      t.references :category

      t.timestamps
    end
  end
end

