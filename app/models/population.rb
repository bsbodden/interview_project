class Population < ApplicationRecord
  def self.get(year, model = :logistic)
    return PopulationResponse.new(year, 0, PopulationResponse::ORIGIN_CALCULATED) if year > 2500
    pop = Population.find_by_year(year)
    return PopulationResponse.new(year, pop.population, PopulationResponse::ORIGIN_EXACT) if pop
    lower_bound = year_range_lower_bound(year)
    return PopulationResponse.new(year, 0, PopulationResponse::ORIGIN_CALCULATED) if lower_bound.nil?
    upper_bound = year_range_upper_bound(year)
    return PopulationResponse.new(year, calculate_population_for_year(year, model), PopulationResponse::ORIGIN_CALCULATED) if upper_bound.nil?
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

  def self.calculate_population_for_year(year, model = :logistic)
    case model
    when :logistic
      logistic_model_population_for_year(year)
    when :exponential
      exponential_model_population_for_year(year)
    end
  end

  EXPONENTIAL_GROWTH_RATE = 0.09

  def self.exponential_model_population_for_year(year)
    last_known = Population.order("year DESC").limit(1).first
    population_increase = last_known.population * ((1 + EXPONENTIAL_GROWTH_RATE) ** (year - last_known.year))
    last_known.population + population_increase
  end

  # United States can't support more than 750MM people even in 2099
  MAX_SUSTAINABLE_POPULATION = 750_000_000

  def self.logistic_model_population_for_year(year)
    initial_year = Population.minimum(:year)
    final_year = Population.maximum(:year)
    initial_year_population = Population.find_by_year(initial_year).population
    final_year_population = Population.find_by_year(final_year).population

    growth_rate = 1.0 / ((final_year - initial_year) * Math.log(final_year_population / initial_year_population))
    a = (MAX_SUSTAINABLE_POPULATION - final_year_population) / final_year_population

    MAX_SUSTAINABLE_POPULATION / (1 + a * (Math::E ** (-1 * growth_rate * (year - final_year))))
  end
end
