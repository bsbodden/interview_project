class Population < ApplicationRecord
  def self.get(year)
    pop = Population.find_by_year(year)

    if pop.nil?
      lower_bound = Population.where("year <= ?", year).order("year DESC").limit(1).first

      if lower_bound.nil?
        0
      else
        upper_bound = Population.where("year >= ?", year).order("year ASC").limit(1).first
        if upper_bound.nil?
          lower_bound.population
        else
          lower_bound.population + ((upper_bound.population - lower_bound.population) * ((year.to_f - lower_bound.year.to_f) / (upper_bound.year.to_f - lower_bound.year.to_f)))
        end
      end
    else
      pop.population
    end
  end
end
