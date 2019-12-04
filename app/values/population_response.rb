class PopulationResponse
  attr_accessor :year, :population, :origin

  ORIGIN_EXACT = 0
  ORIGIN_CALCULATED = 1

  ORIGINS = {
    exact: ORIGIN_EXACT,
    calculated: ORIGIN_CALCULATED,
  }

  def initialize(year, population, origin)
    @year, @population, @origin = year, population, origin
  end

  def to_s
    @population.to_s
  end
end
