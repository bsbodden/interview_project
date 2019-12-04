class Population < ApplicationRecord
  def self.get(year)
    pop = Population.find_by_year(year)

    if pop.nil?
      lower_bound = year_range_lower_bound(year)
      if lower_bound.nil?
        0
      else
        upper_bound = year_range_upper_bound(year)
        if upper_bound.nil?
          lower_bound.population
        else
          linear_progression(lower_bound, upper_bound, year)
        end
      end
    else
      pop.population
    end
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
end
