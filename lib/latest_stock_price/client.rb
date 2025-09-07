require "httparty"

module LatestStockPrice
  class Client
    BASE_URL = "https://latest-stock-price.p.rapidapi.com"

    def initialize(api_key = ENV["RAPIDAPI_KEY"])
      @headers = {
        "X-RapidAPI-Host" => "latest-stock-price.p.rapidapi.com",
        "X-RapidAPI-Key" => api_key
      }
    end

    def price(symbol)
      request("/price?symbol=#{symbol}")
    end

    def prices(symbols)
      request("/prices?symbols=#{symbols.join(',')}")
    end

    def price_all
      request("/any")
    end

    private

      def request(path)
        HTTParty.get("#{BASE_URL}#{path}", headers: @headers).parsed_response
      end
  end
end
