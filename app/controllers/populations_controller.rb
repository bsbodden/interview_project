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
    @population_requests = PopulationRequest.all
  end

  private

  def log_population_request
    PopulationRequest.create(query: params[:year], response: @population) if params[:year] && @population
  end
end
