class StocksController < ApplicationController
  def price
    render json: client.price(params[:symbol])
  end

  def prices
    render json: client.prices(params[:symbols].split(","))
  end

  def price_all
    render json: client.price_all
  end

  private

    def client
      @client ||= LatestStockPrice::Client.new
    end
end
