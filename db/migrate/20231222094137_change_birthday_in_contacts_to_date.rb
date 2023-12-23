class ChangeBirthdayInContactsToDate < ActiveRecord::Migration[7.0]
  def change
    # Set empty strings to NULL
    execute("UPDATE contacts SET birthday = NULL WHERE birthday = ''")

    change_column :contacts, :birthday, 'date USING CAST(birthday AS date)'
  end
end
