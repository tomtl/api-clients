require "json"
require "faraday"

class SymbolNotFound < StandardError; end
class RequestFailed < StandardError; end

# MarkitClient provides access to Markit on Demand API
class MarkitClient
  def initialize(http_client=Faraday.new)
    @http_client = http_client
  end
  
  def last_price(stock_symbol)
    url = "http://dev.markitondemand.com/Api/v2/Quote/json"
    data = make_request(url, symbol: stock_symbol)
    price = data["LastPrice"]
    
    raise SymbolNotFound.new(data["Message"]) unless price
    
    price
  end
  
  private
  
  def make_request(url, params={})
    response = @http_client.get(url, params)
    JSON.load(response.body)
  rescue Faraday::Error => e
    raise RequestFailed, e.message, e.backtrace
  end
end

# StockTotaller calculates the value of stock shares
class StockTotaller
  def initialize(stock_client)
    @stock_client = stock_client
  end
  
  def total_value(stock_symbol, quantity)
    price = @stock_client.last_price(stock_symbol)
    price * quantity
  end
end

def calculate_value(stock_symbol, quantity)
  markit_client = MarkitClient.new
  stock_totaller = StockTotaller.new(markit_client)
  
  stock_totaller.total_value(stock_symbol, quantity.to_i)
end

if $0 == __FILE__
  symbol, quantity = ARGV
  puts calculate_value(symbol, quantity)
end