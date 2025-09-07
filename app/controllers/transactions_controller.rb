class TransactionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    from_wallet = Wallet.find(params[:from_wallet_id])
    to_wallet = Wallet.find(params[:to_wallet_id])
    amount = params[:amount].to_d

    WalletService.transfer(from_wallet, to_wallet, amount)

    render json: { message: "Transfer Succeed!" }, status: :ok
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
