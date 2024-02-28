class AddAdminAndVipToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :vip, :boolean, default: false
  end
end
