class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.string :type, null: false
      t.decimal :amount, precision: 15, scale: 2, null: false
      t.integer :source_wallet_id
      t.integer :target_wallet_id
      t.references :wallet, null: false, foreign_key: true
      t.timestamps
    end

    add_index :transactions, :type
    add_foreign_key :transactions, :wallets, column: :source_wallet_id
    add_foreign_key :transactions, :wallets, column: :target_wallet_id
  end
end
