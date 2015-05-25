feature "Dish search" do 

  before(:each) do 
    search_reindex "Dish"
  end

  scenario "user can see dish search page" do 
    visit root_path

    click_link "Find dish"

    expect(page).to have_css("h1", text: "Find Dish")
  end

end