require 'spec_helper'

describe Beer do


  it "is saved with proper name and style" do
    beer = Beer.create(name: "iso 1", style: "Lager")

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved without a name" do
    beer = Beer.create(style: "Lager")
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.create(name: "Olut")
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

end
