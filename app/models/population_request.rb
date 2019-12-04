class PopulationRequest < ApplicationRecord
  enum origin: PopulationResponse::ORIGINS

  def self.request_counts_for_exact_years
    Population.joins("LEFT OUTER JOIN population_requests on population_requests.query = populations.year")
              .group("populations.year")
              .count("population_requests.id")
  end
end
