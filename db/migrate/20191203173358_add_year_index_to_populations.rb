class AddYearIndexToPopulations < ActiveRecord::Migration[5.2]
  def change
    add_index :populations, :year
  end
end
