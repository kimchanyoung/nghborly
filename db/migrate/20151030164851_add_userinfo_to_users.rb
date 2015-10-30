class AddUserinfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :userinfo, :string
  end
end
