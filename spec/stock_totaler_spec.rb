require_relative '../stock_totaler'

RSpec.describe "stock_totaler" do
  it "calculates stock share" do
    result = calculate_value("TSLA", 1)
    expect(result).to eq(246.27)
  end
end