require 'httparty'

class Stock < ApplicationRecord
  def self.new_lookup(symbol)
    response = HTTParty.get("https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=#{symbol}&apikey=Rails.application.credentials.alpha_vantage_client[:api_key]")
    
    if response.code == 200 && response.parsed_response['Global Quote']
        price = response.parsed_response['Global Quote']['05. price']
        puts "The current price for #{symbol} is #{price}"
        price
    else  
        nil
    end
  end
end


