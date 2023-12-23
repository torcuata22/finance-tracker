require 'httparty'

class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.new_lookup(symbol)
    return nil if symbol.blank?  # Check if the symbol is empty

    api_key = Rails.application.credentials.alpha_vantage_client[:api_key]
    response = HTTParty.get("https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=#{symbol}&apikey=#{api_key}")

    puts "Response Code: #{response.code}"
    puts "Response Body: #{response.body}"

    if response.code == 200 && response.parsed_response['Global Quote'].present?
      global_quote = response.parsed_response['Global Quote']
      price = global_quote['05. price']
      name = global_quote['01. symbol']

      # Check if the response contains valid data for a stock
      if price.present? && name.present?
        stock = new(ticker: symbol, name: name, last_price: price)

        # Check if the new record is valid
        if stock.valid?
          stock
        else
          nil
        end
      else
        nil  # Handle the case where the response does not contain valid stock data
      end
    else
      nil  # Handle the case where the API response is not successful or the "Global Quote" is empty
    end
  end
  def self.check_db(ticker_symbol)
    where(ticker: ticker_symbol).first
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
