class AddIndicesAndUniqueness < ActiveRecord::Migration
  def change
    add_index :users, :email, unique: true
    add_index :groups, :address, unique: true
  end
end
