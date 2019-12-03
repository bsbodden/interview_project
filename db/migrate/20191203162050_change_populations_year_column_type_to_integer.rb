class ChangePopulationsYearColumnTypeToInteger < ActiveRecord::Migration[5.2]
  def up
    change_table :populations do |t|
      t.change :year, :integer
    end
  end

  def down
    change_table :populations do |t|
      t.change :year, :date
    end
  end
end
