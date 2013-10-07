class Stock < ActiveRecord::Base
	validates :stock_name, presence: true
	validates :stock_name, uniqueness: true
	validates :quantity, :years, numericality: {only_integer: true, greater_than: 0}
	validates :price, :percentage, numericality: {greater_than: 0}

	def stock_list_values
		if !@list_values
			@list_values = Hash.new
			temp = self.quantity * self.price
			@list_values[0] = temp
			(1..(self.years)).each do |i|
				temp = temp + temp * (self.percentage/100)
				@list_values[i] = temp.round(2)
			end
		end

		@list_values
	end

	def stock_list_values_dates
		if !@list_values_dates
			self.stock_list_values
			@list_values_dates = Hash.new
			date = Date.today
			@list_values.each do |year, value|
				@list_values_dates[date] = value
				date = date.next_year
			end
		end

		@list_values_dates
	end
end
