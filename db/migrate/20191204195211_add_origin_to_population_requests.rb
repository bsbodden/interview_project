class AddOriginToPopulationRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :population_requests, :origin, :integer
  end
end
