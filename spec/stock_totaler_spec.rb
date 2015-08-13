require "spec_helper"
require_relative "../stock_totaler"

RSpec.describe "stock_totaler" do
  let(:tesla_data) do
    <<-JSON
      {
        "Status": "SUCCESS",
        "Name": "Tesla Motors Inc",
        "Symbol": "TSLA",
        "LastPrice": 123.45,
        "Change": 2.36000000000001,
        "ChangePercent": 0.990888860897684,
        "Timestamp": "Thu Aug 13 13:29:27 UTC-04:00 2015",
        "MSDate": 42229.5621180566,
        "MarketCap": 30581465260,
        "Volume": 144860,
        "ChangeYTD": 222.41,
        "ChangePercentYTD": 8.14711568724428,
        "High": 200.00,
        "Low": 100.00,
        "Open": 150.50
      }
    JSON
  end
  
  it "calculates the value of stock shares" do
    url = "http://dev.markitondemand.com/Api/v2/Quote/json?symbol=TSLA"
    stub_request(:get, url).to_return(body: tesla_data)
    
    result = calculate_value("TSLA", 1)
    expect(result).to eq(123.45)
  end
end