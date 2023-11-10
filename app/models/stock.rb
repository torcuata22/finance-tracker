require httparty

class Stock < ApplicationRecord
  def self.new_lookup(ticker_symbol)
    response = HTTParty.get("https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=#{ticker_symbol}&apikey=API_KEY")
    if response.code == 200 && response.parsed_response['Global Quote']
        reponse.parsed_response['Global Quote']['0.5 price']
    else  
        nil
    end
  end
end
