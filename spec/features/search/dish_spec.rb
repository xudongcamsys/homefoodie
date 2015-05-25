feature "Dish search page" do 

  before(:each) do 
    Dish.reindex 
    Dish.searchkick_index.refresh
  end

  scenario "user view dish search page" do 
    visit root_path

    click_link "Find dish"

    expect(page).to have_css("h1", text: "Find Dish")
  end

end