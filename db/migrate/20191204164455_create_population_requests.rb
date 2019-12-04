class CreatePopulationRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :population_requests do |t|
      t.string :query
      t.decimal :response

      t.timestamps
    end
  end
end
