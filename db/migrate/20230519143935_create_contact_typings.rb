class CreateContactTypings < ActiveRecord::Migration[7.0]
  def change
    create_table :contact_typings do |t|

      t.references :contact
      t.references :contact_type

      t.timestamps
    end
  end
end
