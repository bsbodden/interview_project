require "rails_helper"

RSpec.describe Population, type: :model do
  it "should accept a year we know and return the correct population" do
    expect(Population.get(1900).population).to eq(76212168)
    expect(Population.get(1990).population).to eq(248709873)
  end

  it "should accept a year in the future (after 1990 and at or before 2500) and return a population prediction using an exponential growth model at 9%" do
    expect(Population.get(1992, :exponential).population).to eq(544202073.1113)
    expect(Population.get(1998, :exponential).population).to eq(744279874.5593126)
  end

  it "should accept a year in the future (after 1990 and at or before 2500) and return a population prediction using a logistic growth model" do
    expect(Population.get(1992).population).to eq(253382544.48883402)
    expect(Population.get(1998).population).to eq(263661803.12809205)
  end

  it "should accept a year in the future (after 2500) and return 0" do
    expect(Population.get(2501).population).to eq(0)
  end

  it "should accept a year that is before earliest known and return zero" do
    expect(Population.get(1800).population).to eq(0)
    expect(Population.get(0).population).to eq(0)
    expect(Population.get(-1000).population).to eq(0)
  end

  it "should return a linear progression for years we don't know that are between known years" do
    expect(Population.get(1955).population).to eq(165324486.5)
    expect(Population.get(1956).population).to eq(168124224.2)
    expect(Population.get(1957).population).to eq(170923961.9)
    expect(Population.get(1975).population).to eq(214922115.0)
    expect(Population.get(1977).population).to eq(219570148.6)
    expect(Population.get(1981).population).to eq(228758966.4)
  end
end
