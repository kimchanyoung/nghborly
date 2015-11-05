class AddStreetPredirectionToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :street_predirection, :string
  end
end
