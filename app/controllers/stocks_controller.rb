class StocksController < ApplicationController
    
    def search       
        puts "Parameters: #{params.inspect}"  # Add this line for debugging
        stock = Stock.new_lookup(params[:stock])
        render json: stock   
    end

      
end