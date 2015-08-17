require "json"
require "faraday"

class SymbolNotFound < StandardError; end
class RequestFailed < StandardError; end

def calculate_value(symbol, quantity)
  url = "http://dev.markitondemand.com/Api/v2/Quote/json"
  
  http_client = Faraday.new
  response = http_client.get(url, symbol: symbol)
  data = JSON.load(response.body)
  
  price = data["LastPrice"]
  raise SymbolNotFound.new(data["Message"]) unless price
  price.to_f * quantity.to_i
rescue Faraday::Error => e
  raise RequestFailed, e.message, e.backtrace
end

if $0 == __FILE__
  symbol, quantity = ARGV
  puts calculate_value(symbol, quantity)
end