class PopulationRequest < ApplicationRecord
  enum origin: PopulationResponse::ORIGINS
end
