class WalletService
  def self.transfer(from_wallet, to_wallet, amount)
    ActiveRecord::Base.transaction do
      Debit.create!(wallet: from_wallet, amount: amount, target_wallet: to_wallet, source_wallet: from_wallet)
      Credit.create!(wallet: to_wallet, amount: amount, target_wallet: to_wallet, source_wallet: from_wallet)
    end
  end
end
