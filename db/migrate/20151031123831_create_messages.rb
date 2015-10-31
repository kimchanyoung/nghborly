class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :request_id, null: false
      t.string  :content, null: false, limit: 140
      t.integer :sender, null: false
    end
  end
end
