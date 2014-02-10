require 'spec_helper'
include OwnTestHelper

describe "Beer" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }

  it "with name, new beer is created" do
    visit new_beer_path
    select('Lager', from:'beer[style]')
    select('Koff', from: 'beer[brewery_id]')
    fill_in('beer[name]', with:'Iso 3')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)

    expect(brewery.beers.count).to eq(1)
    expect(Beer.first.brewery).to eq(brewery)
  end

  it "is not created without a name" do
    visit new_beer_path
    select('Lager', from:'beer[style]')
    select('Koff', from: 'beer[brewery_id]')
    fill_in('beer[name]', with:'')

    click_button "Create Beer"


    expect(brewery.beers.count).to eq(0)
    expect(Beer.count).to eq(0)
  end
end