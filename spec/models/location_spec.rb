require 'rails_helper'

describe Location, type: :model do
  before(:each) { 
    @user = create(:user) 
    @location = create(:location, user: @user)
  }

  it "# reindex dishes after being changed" do 
    dish = create(:dish, user: @user)
    search_reindex Dish

    # verify there is 1 in total
    dish_results = Dish.search '*'
    expect(dish_results.count).to eq(1)

    # verify there is 1 nearby
    dish_results = Dish.search '*', where: {location: { near: [1.5, 1.5], within: '0.1mi'}}
    expect(dish_results.count).to eq(1)

    # location change should reindex dishes
    @location.update_attributes(lat: 100, lng: 100)
    search_reindex Dish

    dish_results = Dish.search '*', where: {location: { near: [1.5, 1.5], within: '0.1mi'}}
    expect(dish_results.count).to eq(0)    
  end

  it "# update_latlng when moved > 0.5 mile" do 
    @another_loc = create(:location, user: @user)

    @another_loc.update_latlng(1.5001, 1.5001)

    expect(@another_loc.lat).to eq(1.5)

    @another_loc.update_latlng(1.6, 1.6)

    expect(@another_loc.lat).to eq(1.6)
  end
end

