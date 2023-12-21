require 'httparty'

class Stock < ApplicationRecord
  def self.new_lookup(symbol)
    api_key = Rails.application.credentials.alpha_vantage_client[:api_key]
    response = HTTParty.get("https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=#{symbol}&apikey=#{api_key}")

    puts "Response Code: #{response.code}"
    puts "Response Body: #{response.body}"

    if response.code == 200 && response.parsed_response['Global Quote']
      price = response.parsed_response['Global Quote']['05. price']
      name = response.parsed_response['Global Quote']['01. symbol']
      new(ticker: symbol, name: name, last_price: price)
    else
      nil
    end
  end
end


# require 'httparty'

# class Stock < ApplicationRecord
#   def self.new_lookup(symbol)
#     api_key = Rails.application.credentials.alpha_vantage_client[:api_key]
#     response = HTTParty.get("https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=#{symbol}&apikey=Rails.application.credentials.alpha_vantage_client[:api_key]")

#     if response.code == 200 && response.parsed_response['Global Quote']
#         price = response.parsed_response['Global Quote']['05. price']
#         name = response.parsed_response['Global Quote']['01. symbol']
#        new(ticker: symbol, name: name, last_price: price)
#     else
#         nil
#     end
#   end
# end
