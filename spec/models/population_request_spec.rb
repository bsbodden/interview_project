require "rails_helper"

RSpec.describe PopulationRequest, type: :model do
  let!(:pr1) { PopulationRequest.create(query: 1900, response: 76212168, origin: :exact) }
  let!(:pr2) { PopulationRequest.create(query: 1900, response: 76212168, origin: :exact) }
  let!(:pr3) { PopulationRequest.create(query: 1900, response: 76212168, origin: :exact) }
  let!(:pr4) { PopulationRequest.create(query: 1950, response: 151325798, origin: :exact) }
  let!(:pr5) { PopulationRequest.create(query: 1950, response: 151325798, origin: :exact) }
  let!(:pr6) { PopulationRequest.create(query: 1980, response: 151325798, origin: :exact) }
  let!(:pr7) { PopulationRequest.create(query: 1972, response: 534523452, origin: :calculated) }

  it "should calculate request counts for exact years" do
    expect(PopulationRequest.request_counts_for_exact_years).to eq({1900 => 3, 1910 => 0, 1920 => 0, 1930 => 0, 1940 => 0, 1950 => 2, 1960 => 0, 1970 => 0, 1980 => 1, 1990 => 0})
  end
end
