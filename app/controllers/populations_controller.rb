class PopulationsController < ApplicationController
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
end
