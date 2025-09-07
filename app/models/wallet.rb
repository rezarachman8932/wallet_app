class Wallet < ApplicationRecord
  belongs_to :owner, polymorphic: true
  has_many :transactions

  def balance
    transactions.sum("CASE WHEN type = 'Credit' THEN amount ELSE -amount END")
  end
end
