require "rails_helper"

RSpec.describe Population, type: :model do
  it "should accept a year we know and return the correct population" do
    expect(Population.get(1900)).to eq(76212168)
    expect(Population.get(1990)).to eq(248709873)
  end

  it "should accept a year we don't know and return the previous known population if outside the range of known years" do
    expect(Population.get(1992)).to eq(248709873)
    expect(Population.get(1998)).to eq(248709873)
  end

  it "should accept a year that is before earliest known and return zero" do
    expect(Population.get(1800)).to eq(0)
    expect(Population.get(0)).to eq(0)
    expect(Population.get(-1000)).to eq(0)
  end

  it "should accept a year that is after latest known and return the last known population" do
    expect(Population.get(2000)).to eq(248709873)
    expect(Population.get(200000)).to eq(248709873)
  end

  it "should return a linear progression for years we don't know that are between known years" do
    expect(Population.get(1955)).to eq(165324486.5)
    expect(Population.get(1956)).to eq(168124224.2)
    expect(Population.get(1957)).to eq(170923961.9)
    expect(Population.get(1975)).to eq(214922115.0)
    expect(Population.get(1977)).to eq(219570148.6)
    expect(Population.get(1981)).to eq(228758966.4)
  end
end
