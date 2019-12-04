class Population < ApplicationRecord
  def self.get(year)
    return 0 if year > 2500
    pop = Population.find_by_year(year)
    return pop.population if pop
    lower_bound = year_range_lower_bound(year)
    return 0 if lower_bound.nil?
    upper_bound = year_range_upper_bound(year)
    return calculate_growth_for_year(year) if upper_bound.nil?
    return linear_progression(lower_bound, upper_bound, year)
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
