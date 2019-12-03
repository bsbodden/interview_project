class Population < ApplicationRecord
  def self.min_year
    Population.all.map(&:year).min
  end

  def self.get(year)
    year = year.to_i

    return 0 if year < min_year

    pop = Population.where("year <= ?", year).order("year DESC").limit(1).first

    return pop.population if pop

    nil
  end
end
