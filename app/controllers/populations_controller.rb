class PopulationsController < ApplicationController
  after_action :log_population_request, only: [:index, :show]

  def index
    if params[:year]
      @year = params[:year].to_i
      @population = Population.get(@year)
    end
  end

  def show
    @year = params[:year].to_i
    @population = Population.get(@year)
  end

  def population_requests
    @population_requests_summary = PopulationRequest.request_counts_for_exact_years
    @population_requests = PopulationRequest.all
  end

  private

  def log_population_request
    PopulationRequest.create(query: params[:year], response: @population.population, origin: @population.origin) if params[:year] && @population
  end
end
