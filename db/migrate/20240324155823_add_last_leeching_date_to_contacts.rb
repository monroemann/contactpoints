class AddLastLeechingDateToContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :contacts, :last_leeching_date, :date
  end
end
