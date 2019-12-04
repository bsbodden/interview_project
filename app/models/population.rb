class Population < ApplicationRecord
  def self.get(year)
    return PopulationResponse.new(year, 0, PopulationResponse::ORIGIN_CALCULATED) if year > 2500
    pop = Population.find_by_year(year)
    return PopulationResponse.new(year, pop.population, PopulationResponse::ORIGIN_EXACT) if pop
    lower_bound = year_range_lower_bound(year)
    return PopulationResponse.new(year, 0, PopulationResponse::ORIGIN_CALCULATED) if lower_bound.nil?
    upper_bound = year_range_upper_bound(year)
    return PopulationResponse.new(year, calculate_growth_for_year(year), PopulationResponse::ORIGIN_CALCULATED) if upper_bound.nil?
    return PopulationResponse.new(year, linear_progression(lower_bound, upper_bound, year), PopulationResponse::ORIGIN_CALCULATED)
  end

  private

  def self.linear_progression(lower_bound, upper_bound, year)
    lower_bound.population + ((upper_bound.population - lower_bound.population) * ((year.to_f - lower_bound.year.to_f) / (upper_bound.year.to_f - lower_bound.year.to_f)))
  end

  def self.year_range_upper_bound(year)
    Population.where("year >= ?", year).order("year ASC").limit(1).first
  end

  def self.year_range_lower_bound(year)
    Population.where("year <= ?", year).order("year DESC").limit(1).first
  end

  GROWTH_RATE = 0.09

  def self.calculate_growth_for_year(year)
    last_known = Population.order("year DESC").limit(1).first
    population_increase = last_known.population * ((1 + GROWTH_RATE) ** (year - last_known.year))
    last_known.population + population_increase
  end
end
