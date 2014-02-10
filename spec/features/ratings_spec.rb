require 'spec_helper'
include OwnTestHelper

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }


  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end


  it "shows ratings page correctly if there is ratings" do
    r1 = FactoryGirl.create :rating, user_id: user.id, beer_id: beer1.id
    r2 = FactoryGirl.create :rating2, user_id: user.id, beer_id: beer2.id

    visit ratings_path

    expect(page).to have_content "Number of ratings: #{Rating.count}"
    expect(page).to have_content "#{beer1.name}: #{r1.score} #{user.username}"
    expect(page).to have_content "#{beer2.name}: #{r2.score} #{user.username}"
  end

  it "shows ratings correctly on user page" do
    r1 = FactoryGirl.create :rating, user_id: user.id, beer_id: beer1.id
    r2 = FactoryGirl.create :rating2, user_id: user.id, beer_id: beer2.id
    r3 = FactoryGirl.create :rating2, beer_id: beer2.id
    visit user_path(user)

    expect(Rating.count).to eq(3)
    expect(page).to have_content "has made #{user.ratings.count} ratings. Average: 15"
    expect(page).to have_content "#{beer1.name} #{r1.score}"
    expect(page).to have_content "#{beer2.name} #{r2.score}"

  end

  it "is possible to delete rating" do
    r1 = FactoryGirl.create :rating, user_id: user.id, beer_id: beer1.id
    r2 = FactoryGirl.create :rating2, user_id: user.id, beer_id: beer2.id

    visit user_path(user)

    expect(Rating.count).to eq(2)
    find(:xpath, "(//a[text()='delete'])[1]").click
    expect(Rating.count).to eq(1)
  end
end