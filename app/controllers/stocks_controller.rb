class StocksController < ApplicationController

	def index
  		@stocks = Stock.all
  	end

  	def show
  		@stock = Stock.find(params[:id])
  	end

  	def new
  		@stock = Stock.new

  		render 'data_form'
  	end

  	def create
  		@stock = Stock.new(request.POST[:stock])

  		if @stock.save
  			redirect_to stock_path(:id => @stock.id), :notice => 'Stock data created successfully!'
  		else
  			render 'data_form'
  		end
  	end

  	def edit
  		@stock = Stock.find(params[:id])

  		render 'data_form'
  	end

  	def update
  		@stock = Stock.find(params[:id])

  		if @stock.update_attributes(request.POST[:stock])
  			redirect_to stock_path(:id => @stock.id), :notice => 'Stock data updated successfully!'
  		else
  			render 'data_form'
  		end
  	end

  	def destroy
  		@stock = Stock.find(params[:id])
  		@stock.destroy
  		redirect_to root_path, :notice => 'Stock data deleted!'
  	end

end
