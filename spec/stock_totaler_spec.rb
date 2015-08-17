require "spec_helper"
require_relative "../stock_totaler"

RSpec.describe "stock_totaler" do
  it "calculates the value of stock shares", :vcr do
    result = calculate_value("TSLA", 1)
    expect(result).to eq(252.07)
  end
end