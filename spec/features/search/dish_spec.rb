feature "Search dishes" do 

  scenario "user view dish search page" do 
    visit root_path

    click_link "Find dish"

    expect(page).to have_content("Find Dish")
    #expect(page).to have_css("h1", text: "Find Dish")
  end

end