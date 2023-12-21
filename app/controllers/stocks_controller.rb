 class StocksController < ApplicationController

    def search
        puts "Parameters: #{params.inspect}"  # Added this line for debugging
        @stock = Stock.new_lookup(params[:stock])
        render 'users/my_portfolio'
    end


end
