require "spec_helper"
require_relative "../stock_totaler"

RSpec.describe "stock_totaler" do
  it "calculates the value of stock shares", :vcr do
    result = calculate_value("TSLA", 1)
    expect(result).to eq(251.15)
  end


  it "handles an invalid stock symbol", :vcr do
    expect(->{
      calculate_value("ZZZZ", 1)
    }).to raise_error(SymbolNotFound, /No symbol matches/)
  end
end