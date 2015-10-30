class AddIndicesAndUniqueness < ActiveRecord::Migration
  def change
    add_index :groups, :address, unique: true
  end
end
