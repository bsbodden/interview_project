class Population < ApplicationRecord
  def self.get(year)
    pop = Population.where("year <= ?", year).order("year DESC").limit(1).first
    pop ? pop.population : 0
  end
end
