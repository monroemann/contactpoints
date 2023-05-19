class CreateContactGroupings < ActiveRecord::Migration[7.0]
  def change
    create_table :contact_groupings do |t|

      t.references :contact
      t.references :contact_group

      t.timestamps
    end
  end
end
