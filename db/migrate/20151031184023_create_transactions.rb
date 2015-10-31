class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :request_id, null: false
      t.string :transaction_type, null: false

      t.timestamps null: false
    end
  end
end
