class CreateInteractInteractCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :interact_interact_categories do |t|

      t.references :interaction
      t.references :interaction_category

      t.timestamps
    end
  end
end
