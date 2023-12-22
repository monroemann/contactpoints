class AddDateFirstMetToContact < ActiveRecord::Migration[7.0]
  def change
    add_column :contacts, :date_first_met, :date
  end
end
